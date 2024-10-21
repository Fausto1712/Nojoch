//
//  estadoView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData
import MapKit

struct comunidadView: View {
    @EnvironmentObject var router: Router
    
    @State var comunidad: Comunidad
    @State var tags: [String] = []
    @State var filteredPatrimonios: [Patrimonio] = []
    @State private var selectedTag : Int?
    @State var camera : MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8525139681341,longitude: 14.272090640839773),
        latitudinalMeters: 5000,
        longitudinalMeters: 15000))
    
    @Environment(\.modelContext) private var modelContext
    @Query private var patrimonios: [Patrimonio]
    
    var body: some View {
        ZStack{
            VStack{
                headerComunidad(comunidad: comunidad)
                Spacer()
            }
            
            VStack{
                descripcionComunidad(comunidad: comunidad)
                
                ScrollView{
                    tagsComunidad(tags: tags)
                    
                    postsComunidad(filteredPatrimonios: filteredPatrimonios)
                    
                    ubicacionComunidad(camera: $camera, selectedTag: $selectedTag, comunidad: comunidad)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top, 260)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            filteredPatrimonios = patrimonios.filter{ $0.comunidad == comunidad.nombre }
            collectUniqueTags()
            camera = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: comunidad.coordenadas[0],
                    longitude: comunidad.coordenadas[1]),
                latitudinalMeters: 5000,
                longitudinalMeters: 15000))
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

struct headerComunidad:View {
    var comunidad: Comunidad
    var body: some View {
        ZStack{
            VStack{
                TabView {
                    ForEach(comunidad.fotos, id: \.self) { foto in
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

struct descripcionComunidad:View {
    var comunidad: Comunidad
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(comunidad.nombre)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.rosaMex)
                
                Text(comunidad.estado)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("Zona Rural")
                .fontWeight(.semibold)
                .font(.system(size: 17))
                .foregroundStyle(.rosaMex)
        }
        .padding()
    }
}

struct tagsComunidad: View {
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

struct postsComunidad:View {
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

struct ubicacionComunidad:View {
    @Binding var camera: MapCameraPosition
    @Binding var selectedTag: Int?
    
    var comunidad: Comunidad
    var body: some View {
        VStack{
            HStack{
                Text("Ubicacion")
                    .fontWeight(.semibold)
                    .foregroundStyle(.rosaMex) +
                Text(" de \(comunidad.nombre)")
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading,20)
            
            Map(position: $camera, selection: $selectedTag){
                Marker(comunidad.nombre, coordinate: CLLocationCoordinate2D(latitude: comunidad.coordenadas[0], longitude: comunidad.coordenadas[1]))
                    .tag(comunidad.id)
                UserAnnotation()
            }
            .frame(width: 360, height: 155)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .mapStyle(.standard)
            .mapControls { MapScaleView() }
            .onTapGesture { openGoogleMaps(for: CLLocationCoordinate2D(latitude: comunidad.coordenadas[0], longitude: comunidad.coordenadas[1])) }
        }
        .padding(.bottom, 25)
    }
    
    private func openGoogleMaps(for coordinate: CLLocationCoordinate2D) {
        let urlString = "https://www.google.com/maps/search/?api=1&query=\(coordinate.latitude),\(coordinate.longitude)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    comunidadView(comunidad: Comunidad(id: 0, nombre: "Puerto Genovevo", fotos: ["PTGNV1", "PTGNV2", "PTGNV3"], estado: "Nuevo León", coordenadas: [25.343257560651292, -100.18272756559038]))
}
