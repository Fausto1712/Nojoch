//
//  CustomARView.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 29/10/24.
//

import ARKit
import RealityKit
import SwiftUI

import Combine

class CustomARView: ARView {
    private var initialZPosition: Float?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init coder not implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        configure()
        
        subscribeToActionStream()
        
    }
    
    func configure() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical]
        session.run(configuration)
        addCoachingIfNeeded()
        addCoaching()
    }
    
    func createAnchor() {
        let anchor = AnchorEntity(world: .zero)
        scene.addAnchor(anchor)
        
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .showBadge(let type):
                    self?.loadObj(type)
                    
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    
    func loadObj(_ object: String) {
        guard let cameraTransform = self.session.currentFrame?.camera.transform else {
            print("Camera transform not available.")
            return
        }
        
        let box = try? (Entity.load(named: object))
        var m = MeshResource.generateBox(size: 0.1)
        if (object == "Texto") {
            m = MeshResource.generateText("Cerro de la silla")
        }
        let material = SimpleMaterial(color: .blue, isMetallic: false)

        let entity = ModelEntity(mesh: m, materials: [material])
        
        let cameraPosition = cameraTransform.translation
        let cameraForward = normalize(SIMD3(x: -cameraTransform.columns.2.x,
                                            y: -cameraTransform.columns.2.y,
                                            z: -cameraTransform.columns.2.z))
        
        let distanceInFront: Float = 0.3
        var objectPosition = cameraPosition + (cameraForward * distanceInFront)
        
        if (object == "Texto") {
            objectPosition.y += 0.2
        }
        
        let anchor = AnchorEntity(world: objectPosition)
        
        //make a model entity from loaded entity box
        
        
        
        self.initialZPosition = objectPosition.z
        if let boxEntity = box {
            let wrapperEntity = createWrapper(for: boxEntity)
//            boxEntity.generateCollisionShapes(recursive: true)
            installGestures(on: wrapperEntity)
            anchor.addChild(wrapperEntity)
            scene.addAnchor(anchor)
            print("tap")
        } else {
            print("no")
            installGestures(on: entity)
            anchor.addChild(box ?? entity)
            scene.addAnchor(anchor)
        }
    }
    
    func createWrapper(for entity: Entity) -> ModelEntity {
        let boundingBox = entity.visualBounds(relativeTo: entity)
        let boxSize = boundingBox.extents // Use the exact size of the entity’s bounding box
        
        // Create a visible (semi-transparent) box ModelEntity as the gesture and collision target
        let boxMesh = MeshResource.generateBox(size: boxSize)
        let debugMaterial = SimpleMaterial(color: .gray.withAlphaComponent(0.3), isMetallic: false)
//        let transparentMaterial = SimpleMaterial(color: .clear, isMetallic: false)
        let wrapperEntity = ModelEntity(mesh: boxMesh, materials: [debugMaterial])
        
        // Center the wrapper on the loaded entity
//        let bottomOffset = SIMD3<Float>(0, -boundingBox.extents.y / 2, 0)
        
        entity.position = SIMD3(x: 0, y: -boxSize.y / 2, z: 0)
        
        // Add the internal anchor to the wrapper
        wrapperEntity.addChild(entity)
        
        // Enable collision shapes and install gestures on the wrapper
        wrapperEntity.generateCollisionShapes(recursive: true)
//        installGestures(on: wrapperEntity)
        
        return wrapperEntity
        }
    
    func installGestures(on object: ModelEntity) {
        object.generateCollisionShapes(recursive: true)
        
        // Built-in gestures: rotate, scale, and translation
        self.installGestures([.rotation, .scale, .translation], for: object)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        
        if let entity = self.entity(at: location) {
            print("Tapped on entity: \(entity)")
            startRotating(entity: entity)
        }
    }
    
    private func startRotating(entity: Entity) {
        let rotation = Transform(
            rotation: simd_quatf(angle: .pi, axis: SIMD3(x: 0, y: 1, z: 0))
        )
        
        entity.move(to: rotation, relativeTo: entity, duration: 2.0, timingFunction: .linear)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            entity.move(to: rotation, relativeTo: entity, duration: 1.0, timingFunction: .linear)
        }
    }
    
   
}

extension CustomARView: ARCoachingOverlayViewDelegate {
    func addCoachingIfNeeded() {
        checkCameraAvailability(retries: 5)
    }
    
    private func checkCameraAvailability(retries: Int, delay: TimeInterval = 0.5) {
        guard retries > 0 else {
            print("Camera not ready. Showing coaching overlay.")
            addCoaching()
            return
        }
        
        // Check if camera transform is available
        if let _ = self.session.currentFrame?.camera.transform {
            print("Camera is ready.")
        } else {
            print("Camera not ready, retrying in \(delay) seconds.")
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.checkCameraAvailability(retries: retries - 1, delay: delay)
            }
        }
    }
    
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        
        coachingOverlay.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        self.addSubview(coachingOverlay)
        
        coachingOverlay.goal = .tracking
        coachingOverlay.session = self.session
        coachingOverlay.delegate = self
    }
    
    func coachingOverlayViewDidDeactivate(
        _ coachingOverlayView: ARCoachingOverlayView
    ) {
        print("loading")
    }
    
    
}

// Utility extension to handle matrix transformations
extension simd_float4x4 {
    public var translation: SIMD3<Float> {
        return SIMD3(x: columns.3.x, y: columns.3.y, z: columns.3.z)
    }
}
