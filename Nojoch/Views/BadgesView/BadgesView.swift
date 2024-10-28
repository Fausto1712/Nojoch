//
//  BadgesView.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 22/10/24.
//

import SwiftUI
import RealityKit

struct BadgesView: View {
    var body: some View {
        ZStack {
            CustomARViewRepresentable()
                .ignoresSafeArea()
            
            VStack {

                Button {
                    ARManager.shared.actionStream.send(.showBadge(type: "a"))
                } label: {
                    Text("show")
                }
            }
            
            
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

#Preview {
    BadgesView()
}
