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
    @StateObject var viewModel = ARViewModel()
    
    var body: some View {
        ZStack {
            CustomARViewRepresentable(viewModel: viewModel)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer().frame(height: 50)
                
                Text(viewModel.text)
                    .foregroundStyle(.white)
                    .shadow(radius: 8)
                    .padding(5)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .background(Color(.black.opacity(viewModel.text == "" ? 0 : 0.2)))
                    .padding(20)
                
                
                Spacer()
                
                if !clicked {
                    Button {
                        ARManager.shared.actionStream.send(.showBadge(type: patrimonio.insignia, patrimonio.titulo))
                        clicked = true
                        viewModel.text = "Felicidades, has desbloqueado un nuevo patrimonio: \(patrimonio.titulo)! \nHaz tap para interactuar"
                        
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
                    if !seeAll {
                        
                        Button {
                            ARManager.shared.actionStream.send(.showAllBadges(type: getInsignias()))
                            //                       ARManager.shared.actionStream.send(.showBadge(type: "Texto"))
                            seeAll = true
                            viewModel.text = "Estas son todas tus insignias. \nHaz tap en una para ver más información"
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
                }
                
                
                
                Spacer().frame(height: 50)
                
                
            }
            
            
        }
    }
    
    func getInsignias() -> [String : String] {
        var insignias: [String : String] = [:]
        
        for patrimonio in visitedPatrimonios {
            insignias[patrimonio.titulo] = patrimonio.insignia
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
