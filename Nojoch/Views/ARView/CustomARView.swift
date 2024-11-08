//
//  CustomARView.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 29/10/24.
//

import ARKit
import Combine
import RealityKit
import SwiftUI

class CustomARView: ARView {
    private var initialZPosition: Float?
    var viewModel: ARViewModel?
    
    
    //__ Config __
    
    init(frame frameRect: CGRect, viewModel: ARViewModel) {
        self.viewModel = viewModel
        super.init(frame: frameRect)
        configure()
        subscribeToActionStream()
    }
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        configure()
        subscribeToActionStream()
    }
    
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init coder not implemented")
    }
    
    convenience init(viewModel: ARViewModel) {
        self.init(frame: UIScreen.main.bounds, viewModel: viewModel)
    }
    
    func configure() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        session.run(configuration)
        addCoachingIfNeeded()
        addHorizontalCoaching()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    //__ Action Stream __
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .showBadge(let file, let name):
                    self?.loadObj(file: file, name: name)
                    
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                    
                case .showAllBadges(let type):
                    self?.loadAll(type)
                }
            }
            .store(in: &cancellables)
    }
    
    func loadAll(_ objects: [String: String]) {
        self.scene.anchors.removeAll()
        
        let spacing: Float = 0.19
        let itemsPerRow = 4
        var row = 0
        var col = 0
        let totalRows = (objects.count + itemsPerRow - 1) / itemsPerRow // Calculate total rows needed
        let totalWidth = Float(itemsPerRow - 1) * spacing
        let totalDepth = Float(totalRows - 1) * spacing
        let xOffset = totalWidth / 2
        let zOffset = totalDepth / 2
        let anchor = AnchorEntity(plane: .horizontal)
        
        for object in objects {
            let insignia = try? (Entity.load(named: object.value))
            
            if let insigniaEntity = insignia {
                
                installAllBadgesGestures(on: insigniaEntity)
                setNameRecursively(entity: insigniaEntity, name: object.key)
                insigniaEntity.position = SIMD3(Float(col) * spacing - xOffset, 0, Float(row) * spacing - zOffset)
                insigniaEntity.name = object.key
                anchor.addChild(insigniaEntity)
                scene.addAnchor(anchor)
                
                col += 1
                if col >= itemsPerRow {
                    col = 0
                    row += 1
                }
            }
        }
        
    }
    
    func loadObj(file object: String, name: String) {
        guard let cameraTransform = self.session.currentFrame?.camera.transform else {
            print("Camera transform not available.")
            return
        }
        
        let insignia = try? (Entity.load(named: object))
        let cameraPosition = cameraTransform.translation
        let cameraForward = normalize(SIMD3(x: -cameraTransform.columns.2.x,
                                            y: -cameraTransform.columns.2.y,
                                            z: -cameraTransform.columns.2.z))
        
        let distanceInFront: Float = 0.3
        let objectPosition = cameraPosition + (cameraForward * distanceInFront)
        let anchor = AnchorEntity(world: objectPosition)
        
        if let insigniaEntity = insignia {
            self.initialZPosition = objectPosition.z
            setNameRecursively(entity: insigniaEntity, name: name)
            installGestures(on: insigniaEntity)
            anchor.addChild(insigniaEntity)
            scene.addAnchor(anchor)
        } else {
            let box = MeshResource.generateBox(size: 0.1)
            let material = SimpleMaterial(color: .blue, isMetallic: false)
            let entity = ModelEntity(mesh: box, materials: [material])
            installGestures(on: entity)
            anchor.addChild(entity)
            scene.addAnchor(anchor)
        }
        
    }
    
    func setNameRecursively(entity: Entity, name: String) {
        entity.name = name
        for child in entity.children {
            setNameRecursively(entity: child, name: name)
        }
    }
    
    func createWrapper(for entity: Entity) -> ModelEntity {
        let boundingBox = entity.visualBounds(relativeTo: entity)
        let boxSize = boundingBox.extents
        
        let boxMesh = MeshResource.generateBox(size: boxSize)
        // let debugMaterial = SimpleMaterial(color: .gray.withAlphaComponent(0.3), isMetallic: false)
        let transparentMaterial = SimpleMaterial(color: .clear, isMetallic: false)
        let wrapperEntity = ModelEntity(mesh: boxMesh, materials: [transparentMaterial])
        
        entity.position = SIMD3(x: 0, y: -boxSize.y / 2, z: 0)
        wrapperEntity.addChild(entity)
        wrapperEntity.generateCollisionShapes(recursive: false)
        
        return wrapperEntity
    }
    
    
    // __ Gestures __
    
    func installGestures(on object: Entity) {
        object.generateCollisionShapes(recursive: true)
        //        self.installGestures([.rotation, .scale, .translation], for: object)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func installAllBadgesGestures(on object: Entity) {
        object.generateCollisionShapes(recursive: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        
        if let entity = self.entity(at: location) {
            print("Tapped on entity: \(entity.name)")
            
            viewModel?.setSelection(entity.name)
            
            moveUp(entity: entity)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Animate the second transformation after 1 second
                self.moveDown(entity: entity)
            }
            
        }
    }
    
    
    // __ Animations __
    
    func moveUp(entity: Entity) {
        let scaleFactor: Float = 1.3
        
        let currentPosition = entity.position
        
        let upwardOffset: Float = 0.1
        let targetPosition = SIMD3<Float>(
            currentPosition.x,
            currentPosition.y + upwardOffset,
            currentPosition.z
        )
        
        let backwardRotation = simd_quatf(angle: .pi, axis: SIMD3(x: 0, y: 1, z: 0))
        
        let targetScale = SIMD3<Float>(scaleFactor, scaleFactor, scaleFactor) // Scale down to 30% size
        let targetTransform = Transform(scale: targetScale, rotation: backwardRotation, translation: targetPosition)
        
        entity.move(to: targetTransform, relativeTo: entity.parent, duration: 2.0)
        
    }
    
    func moveDown(entity: Entity) {
        let currentPosition = entity.position
        let targetPosition = SIMD3<Float>(
            currentPosition.x,
            currentPosition.y - 0.1,
            currentPosition.z
        )
        
        let rotation = simd_quatf(angle: 2 * .pi, axis: SIMD3(x: 0, y: 1, z: 0))
        let targetTransform = Transform(scale: SIMD3<Float>(1.0,1.0,1.0), rotation: rotation, translation: targetPosition)
        entity.move(to: targetTransform, relativeTo: entity.parent, duration: 2.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let rotation = simd_quatf(angle: 0, axis: SIMD3(x: 0, y: 1, z: 0))
            let prev = Transform(scale: SIMD3<Float>(1.0,1.0,1.0), rotation: rotation, translation: targetPosition)
            entity.move(to: prev, relativeTo: entity.parent, duration: 0.1)
        }
        
    }
    
    private func startRotating(entity: Entity) {
        let rotation = Transform(
            rotation: simd_quatf(angle: .pi, axis: SIMD3(x: 0, y: 1, z: 0))
        )
        
        entity.move(to: rotation, relativeTo: entity, duration: 1.5, timingFunction: .linear)
        
        let rotationBack = Transform(
            rotation: simd_quatf(angle: 2 * .pi, axis: SIMD3(x: 0, y: 1, z: 0))
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            
            entity.move(to: rotationBack, relativeTo: entity, duration: 1.5, timingFunction: .linear)
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
    
    func addHorizontalCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        
        coachingOverlay.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        self.addSubview(coachingOverlay)
        
        coachingOverlay.goal = .horizontalPlane
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
