//
//  estadoView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct estadoView: View {
    @State var estado: Estado
    @State var tags: [String] = []
    @State var filteredPatrimonios: [Patrimonio] = []
    @State var filteredComunidades: [Comunidad] = []
    
    @Environment(\.modelContext) private var modelContext
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    @Query private var patrimonios: [Patrimonio]
    
    var body: some View {
        ZStack{
            VStack{
                headerEstado(estado: estado)
                Spacer()
            }
            
            VStack{
                descripcionEstado(estado: estado, filteredComunidades: filteredComunidades)
                
                ScrollView{
                    tagsEstado(tags: tags)
                    
                    postsEstado(filteredPatrimonios: filteredPatrimonios)
                    
                    comunidadesEstado(filteredComunidades: filteredComunidades)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top, 260)
        }
        .ignoresSafeArea()
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

struct headerEstado:View {
    var estado: Estado
    var body: some View {
        ZStack{
            VStack{
                TabView {
                    ForEach(estado.fotos, id: \.self) { foto in
                        Image(foto)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 350)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    UIPageControl.appearance().backgroundStyle = .prominent
                }
            }
            
            VStack{
                HeaderAppViewComponent()
                    .padding(.horizontal, 30)
                    .padding(.top, 50)
                Spacer()
            }
        }
        .frame(height: 270)
    }
}

struct descripcionEstado:View {
    var estado: Estado
    var filteredComunidades: [Comunidad]
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(estado.nombre)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.rosaMex)
                
                Text(estado.ubicacion)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("\(filteredComunidades.count) comunidades")
                .fontWeight(.semibold)
                .font(.system(size: 17))
                .foregroundStyle(.rosaMex)
        }
        .padding()
    }
}

struct tagsEstado: View {
    var tags: [String]
    var body: some View {
        HStack{
            Text("Tags")
                .fontWeight(.semibold)
                .foregroundStyle(.rosaMex) +
            Text(" de interes")
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.leading,20)
        
        ScrollView(.horizontal){
            HStack{
                ForEach(tags, id: \.self){ tag in
                    tagCard(tag: tag)
                }
            }
            .padding(.bottom, 5)
        }
        .frame(height: 50)
        .padding(.leading, 20)
        .padding(.bottom)
        .scrollIndicators(.hidden)
    }
}

struct postsEstado:View {
    var filteredPatrimonios: [Patrimonio]
    var body: some View {
        HStack{
            Text("Posts")
                .fontWeight(.semibold)
                .foregroundStyle(.rosaMex) +
            Text(" recientes")
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.leading,20)
        
        ScrollView(.horizontal){
            HStack{
                ForEach(filteredPatrimonios, id: \.self){ patrimonio in
                    patrimonioEstadoCard(patrimonio: patrimonio)
                }
            }
            .padding(.bottom, 5)
        }
        .padding(.leading, 20)
        .padding(.bottom)
        .scrollIndicators(.hidden)
    }
}

struct comunidadesEstado:View {
    @EnvironmentObject var router: Router
    
    var filteredComunidades: [Comunidad]
    
    var body: some View {
        HStack{
            Text("Comunidades")
                .fontWeight(.semibold)
                .foregroundStyle(.rosaMex) +
            Text(" del estado")
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.leading,20)
        
        ForEach(filteredComunidades, id: \.self){ comunidad in
            HStack{
                comunidadCard(comunidad: comunidad)
                    .onTapGesture { router.navigate(to: .comunidadView(comunidad: comunidad)) }
            }
        }
    }
}

#Preview {
    estadoView(estado: Estado(id: 18, nombre: "Nuevo León", icono: "Im2", fotos: ["NL1", "NL2", "NL3"], ubicacion: "Norte de Mexico"))
}
