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
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HeaderAppView(headerTitle: "Explora")
                .padding(.horizontal, 20)
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                TextField("Coahuila, Sierra Tarahumara...", text: $searchText)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(10)
            
            HStack(spacing: 10){
                Text("Estados")
                    .foregroundStyle(.black.opacity(0.8))
                    .fontWeight(.semibold)
                    .padding(10)
                    .background(selectedCategory == "Estado" ? .gray.opacity(0.2) : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .onTapGesture {
                        selectedCategory = "Estado"
                    }
                
                Text("Comunidades")
                    .foregroundStyle(.black.opacity(0.8))
                    .padding(10)
                    .background(selectedCategory == "Comunidades" ? .gray.opacity(0.2) : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .onTapGesture {
                        selectedCategory = "Comunidad"
                    }
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView {
                if selectedCategory == "Estado" {
                    HStack{
                        Text("Descubre")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                            .foregroundStyle(.rosaMex) +
                        Text(" por estado")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                        Spacer()
                    }
                    .padding(.horizontal)
                    ForEach(filteredEstados(), id: \.id) { estado in
                        estadoCard(estado: estado)
                            .padding(.top)
                            .onTapGesture {
                                router.navigate(to: .estadoView(estado: estado))
                            }
                    }
                }
                
                if selectedCategory == "Comunidad" {
                    HStack{
                        Text("Descubre")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                            .foregroundStyle(.rosaMex) +
                        Text(" por comunidad")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                        Spacer()
                    }
                    .padding(.horizontal)
                    ForEach(filteredComunidades(), id: \.id) { comunidad in
                        comunidadCard(comunidad: comunidad)
                            .padding(.top)
                            .onTapGesture {
                                router.navigate(to: .comunidadView(comunidad: comunidad))
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private func filteredEstados() -> [Estado] {
        if searchText.isEmpty {
            return estados
        } else {
            return estados.filter { $0.nombre.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private func filteredComunidades() -> [Comunidad] {
        if searchText.isEmpty {
            return comunidades
        } else {
            return comunidades.filter { $0.nombre.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct estadoCard:View {
    var estado: Estado
    var body: some View {
        HStack{
            Image(estado.icono)
                .resizable()
                .frame(width: 50, height: 50)
                .shadow(radius: 5)
            
            Text(estado.nombre)
                .font(.system(size: 20))
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 20)
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 3))
        .padding(.horizontal)
    }
}

#Preview {
    exploreView()
}
