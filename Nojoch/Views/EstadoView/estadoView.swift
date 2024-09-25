//
//  estadoView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct estadoView: View {
    @EnvironmentObject var router: Router
    
    @State var estado: Estado
    @State var tags: [String] = []
    @State var filteredPatrimonios: [Patrimonio] = []
    @State var filteredComunidades: [Comunidad] = []
    
    @Environment(\.modelContext) private var modelContext
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    @Query private var patrimonios: [Patrimonio]
    
    var body: some View {
        VStack{
            HeaderAppViewComponent()
                .padding(.horizontal, 30)
            
            TabView {
                ForEach(estado.fotos, id: \.self) { foto in
                    Image(foto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .clipped()
                }
            }
            .frame(width: 350, height: 200)
            .tabViewStyle(PageTabViewStyle())
            
            Text(estado.nombre)
                .font(.system(size: 25))
                .fontWeight(.semibold)
            ScrollView{
                HStack{
                    Text("Tags de interes")
                        .fontWeight(.semibold)
                        .padding(.leading,20)
                    Spacer()
                }
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(tags, id: \.self){ tag in
                            VStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.gray.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                
                                Text(tag)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.bottom)
                .scrollIndicators(.hidden)
                
                HStack{
                    Text("Patrimonios Recientes")
                        .fontWeight(.semibold)
                        .padding(.leading,20)
                    Spacer()
                }
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(filteredPatrimonios, id: \.self){ patrimonio in
                            VStack{
                                Image(patrimonio.fotos[0])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 220, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .clipped()
                                
                                HStack{
                                    Image(patrimonio.personaFoto)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                    Text(patrimonio.persona)
                                        .font(.system(size: 10))
                                    Spacer()
                                    Text(patrimonio.idioma)
                                        .font(.system(size: 10))
                                }
                            }
                            .onTapGesture {
                                router.navigate(to: .patrimonio(patrimonio: patrimonio))
                            }
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.bottom)
                .scrollIndicators(.hidden)
                
                HStack{
                    Text("Comunidades")
                        .fontWeight(.semibold)
                        .padding(.leading,20)
                    Spacer()
                }
                
                ForEach(filteredComunidades, id: \.self){ comunidad in
                    HStack{
                        comunidadCard(comunidad: comunidad)
                            .onTapGesture { router.navigate(to: .comunidadView(comunidad: comunidad)) }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            filteredPatrimonios = patrimonios.filter{ $0.estado == estado.nombre }
            filteredComunidades = comunidades.filter{ $0.estado == estado.nombre }
            collectUniqueTags()
        }
    }
    
    func collectUniqueTags() {
        var uniqueTagsSet = Set<String>()
        filteredPatrimonios.forEach { patrimonio in
            patrimonio.tags.forEach { tag in
                uniqueTagsSet.insert(tag)
            }
        }
        tags = Array(uniqueTagsSet)
    }
}


#Preview {
    estadoView(estado: Estado(id: 18, nombre: "Nuevo León", fotos: ["NL1", "NL2", "NL3"]))
}
