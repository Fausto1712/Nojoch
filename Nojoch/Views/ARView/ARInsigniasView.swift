//
//  BadgesView.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 22/10/24.
//

import SwiftUI
import RealityKit

struct ARInsigniasView: View {
    var patrimonio: Patrimonio
    var visitedPatrimonios: [Patrimonio]
    
    @State var clicked = false
    @State var seeAll = false
    
    var body: some View {
        ZStack {
            CustomARViewRepresentable()
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 50)
                
                Text("Felicidades, has desbloqueado un nuevo patrimonio: \(patrimonio.titulo)!")
                    .foregroundStyle(.white)
                    .shadow(radius: 6)
                    .padding(50)
                    .font(.title2)
                
                Spacer()
                
                if !clicked {
                    Button {
                        ARManager.shared.actionStream.send(.showBadge(type: patrimonio.insignia))
//                       ARManager.shared.actionStream.send(.showBadge(type: "Texto"))
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
                } else {
                    Button {
                        ARManager.shared.actionStream.send(.showAllBadges(type: getInsignias()))
//                       ARManager.shared.actionStream.send(.showBadge(type: "Texto"))
                        clicked = true
                    } label: {
                        HStack {
                            Image(systemName: "trophy.fill")
                            
                            Text("Ver todas mis insignias")
                        }
                        .font(.headline)
                        .padding()
                        .background(.rosaMex)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                
                if seeAll {
                    
                }
                
                Spacer().frame(height: 50)
                
                
            }
            
            
        }
    }
    
    func getInsignias() -> [String] {
        var insignias: [String] = []
        
        for patrimonio in visitedPatrimonios {
            insignias.append(patrimonio.insignia)
        }
        
        
        return insignias
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
    ARInsigniasView(patrimonio: Patrimonio(id: 0, tags: ["Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho mas", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5), visitedPatrimonios: [])
}
