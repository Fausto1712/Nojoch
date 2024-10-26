//
//  patrimonioView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData
import MapKit

struct patrimonioView: View {
    @State var patrimonio: Patrimonio
    @State private var selectedTag : Int?
    @State var camera : MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.8525139681341,longitude: 14.272090640839773), latitudinalMeters: 5000, longitudinalMeters: 15000))
    
    @Query(filter: #Predicate<Estado> { estado in estado.nombre == "Nuevo León" }) var estado: [Estado]
    
    var body: some View {
        ZStack{
            VStack{
                headerPatrimonio(patrimonio: patrimonio)
                Spacer()
            }
            
            VStack{
                descripcionPatrimonio(patrimonio: patrimonio)
                
                ScrollView{
                    tagsPatrimonio(tags: patrimonio.tags)
                    
                    descripcionPostPatrimonio(patrimonio: patrimonio)
                    
                    ubicacionPatrimonio(camera: $camera, selectedTag: $selectedTag, patrimonio: patrimonio)
                    
                    estadoPatrimonio(estado: estado[0])
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top, 260)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            camera = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: patrimonio.coordinates[0],
                    longitude: patrimonio.coordinates[1]),
                latitudinalMeters: 5000,
                longitudinalMeters: 15000))
        }
    }
}

struct headerPatrimonio:View {
    var patrimonio: Patrimonio
    var body: some View {
        ZStack{
            VStack{
                TabView {
                    ForEach(patrimonio.fotos, id: \.self) { foto in
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

struct descripcionPatrimonio:View {
    var patrimonio: Patrimonio
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(patrimonio.titulo)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(.rosaMex)
                    
                    Text(patrimonio.estado)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                HStack{
                    Text("Por:")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundStyle(.rosaMex)
                    Image(patrimonio.personaFoto)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    Text(patrimonio.persona)
                }
            }
            .padding()
        }
    }
}

struct tagsPatrimonio: View {
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

struct descripcionPostPatrimonio:View {
    var patrimonio: Patrimonio
    var body: some View {
        HStack{
            Text("Descripción")
                .fontWeight(.semibold)
                .foregroundStyle(.rosaMex) +
            Text(" del patrimonio")
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.leading,20)
        
        HStack{
            Text(patrimonio.descripcion)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 5)
        .padding(.horizontal,20)
    }
}

struct ubicacionPatrimonio:View {
    @Binding var camera: MapCameraPosition
    @Binding var selectedTag: Int?
    
    var patrimonio: Patrimonio
    var body: some View {
        VStack{
            HStack{
                Text("Ubicacion")
                    .fontWeight(.semibold)
                    .foregroundStyle(.rosaMex) +
                Text(" de \(patrimonio.titulo)")
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading,20)
            
            Map(position: $camera, selection: $selectedTag){
                Marker(patrimonio.titulo, coordinate: CLLocationCoordinate2D(latitude: patrimonio.coordinates[0], longitude: patrimonio.coordinates[1]))
                    .tag(patrimonio.id)
                UserAnnotation()
            }
            .frame(width: 360, height: 155)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .mapStyle(.standard)
            .mapControls { MapScaleView() }
            .onTapGesture { openGoogleMaps(for: CLLocationCoordinate2D(latitude: patrimonio.coordinates[0], longitude: patrimonio.coordinates[1])) }
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

struct estadoPatrimonio:View {
    @EnvironmentObject var router: Router
    
    var estado: Estado
    
    var body: some View {
        estadoCard(estado: estado)
            .onTapGesture {
                router.navigate(to: .estadoView(estado: estado))
            }
            .padding(.bottom, 25)
    }
}

#Preview {
    patrimonioView(patrimonio: Patrimonio(id: 0, tags: ["Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho mas", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
}
