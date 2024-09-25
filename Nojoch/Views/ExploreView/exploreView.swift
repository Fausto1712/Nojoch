//
//  exploreView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct exploreView: View {
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var modelContext
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    
    @State private var selectedCategory: String = "Estado"
    
    var body: some View {
        VStack{
            HeaderAppView(headerTitle: "Explora")
                .padding(.horizontal, 20)
            
            Text("Future search bar")
            
            HStack(spacing: 10){
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 40, height:40)
                    .foregroundStyle(.gray.opacity(0.2))
                    .overlay( RoundedRectangle(cornerRadius: 5) .stroke(.gray, lineWidth: 1))
                
                Text("Estados")
                    .foregroundStyle(.black.opacity(0.8))
                    .fontWeight(.semibold)
                    .padding(10)
                    .background(selectedCategory == "Estado" ? .green.opacity(0.5) : .gray.opacity(0.2))
                    .overlay( RoundedRectangle(cornerRadius: 5) .stroke(selectedCategory == "Estado" ? .green : .gray, lineWidth: 2))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .onTapGesture {
                        selectedCategory = "Estado"
                    }
                
                
                Text("Comunidades")
                    .foregroundStyle(.black.opacity(0.8))
                    .padding(10)
                    .background(selectedCategory == "Comunidades" ? .green.opacity(0.5) : .gray.opacity(0.2))
                    .overlay( RoundedRectangle(cornerRadius: 5) .stroke(selectedCategory == "Comunidades" ? .green : .gray, lineWidth: 2))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .onTapGesture {
                        selectedCategory = "Comunidades"
                    }
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView{
                if selectedCategory == "Estado" {
                    HStack{
                        Text("Aventurate en los estados")
                        Spacer()
                    }
                    .padding(.horizontal)
                    ForEach(estados, id: \.id) { estado in
                        estadoCard(estado: estado)
                            .padding(.top)
                            .onTapGesture { router.navigate(to: .estadoView(estado: estado)) }
                    }
                }
                
                if selectedCategory == "Comunidades" {
                    HStack{
                        Text("Descubre las comunidades rurales")
                        Spacer()
                    }
                    .padding(.horizontal)
                    ForEach(comunidades, id: \.id) { comunidad in
                        comunidadCard(comunidad: comunidad)
                            .padding(.top)
                            .onTapGesture { router.navigate(to: .comunidadView(comunidad: comunidad)) }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct estadoCard:View {
    var estado: Estado
    var body: some View {
        HStack{
            Image(estado.fotos[0])
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay( RoundedRectangle(cornerRadius: 10) .stroke(.gray, lineWidth: 1))
            
            Text(estado.nombre)
                .font(.system(size: 20))
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 20)
        }
        .padding(.horizontal)
    }
}

#Preview {
    exploreView()
}
