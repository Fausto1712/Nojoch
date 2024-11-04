//
//  exploreView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData
import MapKit
import CoreLocation

struct exploreView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresentingMap: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            if isPresentingMap {
                mapExploreView(isPresentingMap: $isPresentingMap)
            } else {
                searchExploreView(isPresentingMap: $isPresentingMap)
            }
        }
    }
    
}

struct mapExploreView:View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var locationManager: LocationManager
    
    @Binding var isPresentingMap: Bool
    
    @State private var selectedTag: Int?
    @State private var nearbyPatrimonio: Patrimonio? = nil
    @State private var filteredPatrimonios: [Patrimonio : Bool] = [:]
    @State private var visitedPatrimonios: [Patrimonio] = []
    @State private var isFollowingUser: Bool = true
    
    @Query private var patrimonios: [Patrimonio]
    
    var body: some View {
        ZStack {
            Map(position: $locationManager.camera, selection: $selectedTag) {
                ForEach(filteredPatrimonios.keys.sorted(by: { $0.titulo < $1.titulo }), id: \.self) { patrimonio in
                    Marker(patrimonio.titulo, coordinate: CLLocationCoordinate2D(latitude: patrimonio.coordinates[0], longitude: patrimonio.coordinates[1]))
                        .tint(filteredPatrimonios[patrimonio] == true ? .rosaMex : .blue)
                        .tag(patrimonio.id)
                }
                UserAnnotation()
            }
            .mapStyle(.standard)
            .mapControls {
                MapScaleView()
            }
            
            if nearbyPatrimonio != nil {
                VStack {
                    Spacer()
                    Button(action: {
                        
                        print(nearbyPatrimonio?.titulo ?? "")
                    }) {
                        HStack{
                            Image(systemName: "camera.fill")
                            
                            NavigationLink {
                                ARInsigniasView(patrimonio: nearbyPatrimonio?.titulo ?? "Cerro de la silla")
                            } label: {
                                Text(" Abrir Cámara")
                            }
                        }
                        .font(.headline)
                        .padding()
                        .background(.rosaMex)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    Spacer().frame(height: 50)
                }
            }
            
            VStack {
                HeaderAppViewExplore(isPresentingmap: $isPresentingMap, headerTitle: "Explora")
                    .padding(.horizontal, 20)
                    .background(.white)
                Spacer()
            }
        }
        .onAppear{
            mapPatrimonios()
            selectedTag = nil
        }
        .onChange(of: selectedTag) {
            if selectedTag != nil {
                router.navigate(to: .patrimonio(patrimonio: patrimonios.first(where: { $0.id == selectedTag })!))
            }
        }
    }
    
    func mapPatrimonios() {
        guard let userLocation = locationManager.location else { return }
        
        var minDistance = 10000.00
        nearbyPatrimonio = nil
        filteredPatrimonios.removeAll()
        visitedPatrimonios.removeAll()
        
        for patrimonio in patrimonios {
            let patrimonioLocation = CLLocation(latitude: patrimonio.coordinates[0], longitude: patrimonio.coordinates[1])
            let distance = userLocation.distance(from: patrimonioLocation)
            
            if patrimonio.visited {
                visitedPatrimonios.append(patrimonio)
            }
            
            if distance <= minDistance {
                minDistance = distance
                nearbyPatrimonio = patrimonio
                filteredPatrimonios[patrimonio] = true
            } else {
                filteredPatrimonios[patrimonio] = false
            }
        }
    }
}

struct searchExploreView:View {
    @EnvironmentObject var router: Router
    
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    
    @State private var selectedCategory: String = "Estado"
    @State private var searchText: String = ""
    
    @Binding var isPresentingMap: Bool
    
    var body: some View {
        VStack{
            HeaderAppViewExplore(isPresentingmap: $isPresentingMap, headerTitle: "Explora")
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
                    .background(selectedCategory == "Comunidad" ? .gray.opacity(0.2) : .clear)
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

#Preview {
    exploreView()
}
