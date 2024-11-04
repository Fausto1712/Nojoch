//
//  BadgesView.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 22/10/24.
//

import SwiftUI
import RealityKit

struct ARInsigniasView: View {
    var patrimonio: String
    @State var clicked = false
    
    var body: some View {
        ZStack {
            CustomARViewRepresentable()
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 50)
                
                Text("Felicidades, has desbloqueado un nuevo patrimonio: \(patrimonio)!")
                    .foregroundStyle(.white)
                    .shadow(radius: 6)
                    .padding(50)
                    .font(.title2)
                
                Spacer()
                
//                if !clicked {
                    Button {
                        ARManager.shared.actionStream.send(.showBadge(type: "alebrije"))
//                        ARManager.shared.actionStream.send(.showBadge(type: "Texto"))
                        clicked = true
                    } label: {
                        HStack {
                            Image(systemName: "trophy.fill")
                            
                            Text("Ver insignia")
                        }
                        .font(.headline)
                        .padding()
                        .background(.rosaMex)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
//                }
                
                Spacer().frame(height: 50)
                
                
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
    ARInsigniasView(patrimonio: "Cerro de la silla")
}
