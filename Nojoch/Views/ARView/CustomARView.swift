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
    public var selected = ""
    private var mainEntity: ModelEntity?
    var viewModel: ARViewModel?
    
    
        
//    func setViewModel(vm: ARViewModel) {
//        viewModel = vm
//    }
    init(frame frameRect: CGRect, viewModel: ARViewModel) {
            self.viewModel = viewModel
            super.init(frame: frameRect)
            configure()
            subscribeToActionStream()
        }

        // Required initializer with frame
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
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .showBadge(let type):
                    self?.loadObj(type)
                    
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                    
                case .showAllBadges(let type):
                    self?.loadAll(type)
                }
                
            
                
                
            }
            .store(in: &cancellables)
    }
    
    func loadAll(_ objects: [String: String]) {
//        guard let cameraTransform = self.session.currentFrame?.camera.transform else {
//            print("Camera transform not available.")
//            return
//        }
//        self.scene.anchors.removeAll()
        
//        animateToTopRight()
        
//        addHorizontalCoaching()
        self.scene.anchors.removeAll()
        
        let spacing: Float = 0.15 // Adjust this value to control spacing between objects
        let itemsPerRow = 4
        var row = 0
        var col = 0
            
        
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        for object in objects {
            print("Objeto: ")
            print(object)
            let insignia = try? (Entity.load(named: object.value))
            
            
            if let insigniaEntity = insignia {
//                insigniaEntity.position = SIMD3(Float(col) * spacing, 0, Float(row) * spacing)
                insigniaEntity.name = object.key
                let wrapperEntity = createWrapper(for: insigniaEntity)
    //            boxEntity.generateCollisionShapes(recursive: true)
                installAllBadgesGestures(on: wrapperEntity)
//                installGestures(on: wrapperEntity)
                wrapperEntity.position = SIMD3(Float(col) * spacing, 0, Float(row) * spacing)
                wrapperEntity.name = object.key
                anchor.addChild(wrapperEntity)
                scene.addAnchor(anchor)
                
                col += 1
                if col >= itemsPerRow {
                    col = 0
                    row += 1
                }
            }
        }
        
        
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
            boxEntity.name = object
            let wrapperEntity = createWrapper(for: boxEntity)
            wrapperEntity.name = object
//            boxEntity.generateCollisionShapes(recursive: true)
            installGestures(on: wrapperEntity)
            self.mainEntity = wrapperEntity
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
//        let debugMaterial = SimpleMaterial(color: .gray.withAlphaComponent(0.3), isMetallic: false)
        let transparentMaterial = SimpleMaterial(color: .clear, isMetallic: false)
//        let transparentMaterial = UnlitMaterial(color: .white.withAlphaComponent(0.0))
        let wrapperEntity = ModelEntity(mesh: boxMesh, materials: [transparentMaterial])
        
        // Center the wrapper on the loaded entity
//        let bottomOffset = SIMD3<Float>(0, -boundingBox.extents.y / 2, 0)
        
        entity.position = SIMD3(x: 0, y: -boxSize.y / 2, z: 0)
        
        
        // Add the internal anchor to the wrapper
        wrapperEntity.addChild(entity)
        
        // Enable collision shapes and install gestures on the wrapper
        wrapperEntity.generateCollisionShapes(recursive: false)
//        installGestures(on: wrapperEntity)
        
        return wrapperEntity
        }
    
    func animateToTopRight() {
        
        guard let entity = self.mainEntity else { return }
        let scaleFactor: Float = 0.3
        let targetPosition = SIMD3<Float>(0.1, 0.5, -0.3) // Adjust based on AR scene
//        let targetPosition = SIMD3<Float>(0.15, 0.15, -0.5)
        let targetScale = SIMD3<Float>(scaleFactor, scaleFactor, scaleFactor)     // Scale down to 10% size

                // Create a Transform with the target position and scale
                let targetTransform = Transform(scale: targetScale, rotation: entity.orientation, translation: targetPosition)

                // Animate both the position and scale using move(to:duration:)
                entity.move(to: targetTransform, relativeTo: entity.parent, duration: 1.0)
        
        }
    

    
    func installGestures(on object: ModelEntity) {
        object.generateCollisionShapes(recursive: false)
        
        // Built-in gestures: rotate, scale, and translation
        self.installGestures([.rotation, .scale, .translation], for: object)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func installAllBadgesGestures(on object: ModelEntity) {
//        object.generateCollisionShapes(recursive: true)
        
        // Built-in gestures: rotate, scale, and translation
//        self.installGestures([.rotation, .scale, .translation], for: object)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        
        if let entity = self.entity(at: location) {
            print("Tapped on entity: \(entity.name)")
            
            selected = entity.name
            viewModel?.setSelection(entity.name)
            
            
            moveUp(entity: entity)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                self.startRotating(entity: entity)
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // Animate the second transformation after 1 second
                self.moveDown(entity: entity)
                }
            
        }
    }
    
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
//        let currentAngle = entity.transform.rotation.angle
        
        let rotation = simd_quatf(angle: 2 * .pi, axis: SIMD3(x: 0, y: 1, z: 0))
//        let rotation = entity.orientation
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
