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
                    
                    estadoPatrimonio(estado: estado[0], patrimonio: patrimonio)
                }
                .scrollIndicators(.hidden)
                .padding(.top, -22)
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
                        .foregroundStyle(.rosaMex)
                        .font(.custom(.poppinsBold, style: .title2))
                    
                    HStack{
                        Image(patrimonio.personaFoto)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                        Text(patrimonio.persona)
                            .font(.custom(.raleway, style: .custom14))
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, -16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .padding(.top, 4)
        }
        
        Rectangle()
            .foregroundStyle(.quinary)
            .frame(maxWidth: .infinity)
            .frame(height: 4)
            .padding(.top, -12)
            .padding(.bottom, 6)
    }
}

struct tagsPatrimonio: View {
    var tags: [String]
    var body: some View {
        HStack{
            Text("Tags")
                .fontWeight(.semibold)
                .foregroundStyle(.rosaMex) +
            Text(" de interés")
                .fontWeight(.semibold)
            Spacer()
        }
        .font(.custom(.poppinsSemiBold, style: .body))
        .padding(.horizontal)
        .padding(.vertical, 14)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 16)
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        tagCard(tag: tag)
                    }
                }
                Spacer()
                    .frame(width: 16)
            }
            .padding(.bottom, 5)
        }
        .frame(height: 50)
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
        .font(.custom(.poppinsSemiBold, style: .body))
        .padding(.horizontal)
        .padding(.top, 4)
        .padding(.bottom, 2)
        
        HStack{
            Text(patrimonio.descripcion)
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .font(.custom(.raleway, style: .subheadline))

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal,16)
        .padding(.bottom, 12)
    }
}

struct ubicacionPatrimonio:View {
    @Binding var camera: MapCameraPosition
    @Binding var selectedTag: Int?
    
    var patrimonio: Patrimonio
    var body: some View {
        VStack{
            HStack{
                Text("Ubicación")
                    .fontWeight(.semibold)
                    .foregroundStyle(.rosaMex) +
                Text(" de \(patrimonio.titulo)")
                    .fontWeight(.semibold)
                Spacer()
            }
            .font(.custom(.poppinsSemiBold, style: .body))
            .padding(.horizontal)
            .padding(.bottom, 4)
            
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
        .padding(.bottom, 16)
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
    var patrimonio: Patrimonio
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Explora")
                    .fontWeight(.semibold)
                    .foregroundStyle(.rosaMex) +
                Text(" \(patrimonio.estado)")
                    .fontWeight(.semibold)
                Spacer()
            }
            .font(.custom(.poppinsSemiBold, style: .body))
            .padding(.horizontal)
            .padding(.bottom, 4)
            
            estadoCard(estado: estado)
                .padding(.bottom, 32)
                .onTapGesture {
                    router.navigate(to: .estadoView(estado: estado))
                }
        
        }
    }
}

#Preview {
//  patrimonioView(patrimonio: Patrimonio(id: 0, tags: ["Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho mas", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
}
