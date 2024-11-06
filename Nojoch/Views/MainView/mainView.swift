//
//  mainView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

struct TagTranslations {
    let original: String
    let nahualt: String
    let maya: String
}

import SwiftUI
import SwiftData

struct mainView: View {
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var modelContext
    @Query private var patrimonios: [Patrimonio]
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    
    var body: some View {
        VStack(alignment: .leading){
            
            HeaderAppView(headerTitle: "Herencia Viva")
                .padding(.horizontal, 32)
            
            ScrollView{
                HStack{
                    Text("Patrimonios")
                        .foregroundStyle(.rosaMex) +
                    Text(" de hoy")
                    Spacer()
                }
                .font(.custom(.poppinsSemiBold, style: .headline))
                .padding(.top, 14)
                .padding(.bottom, 10)
                .padding([.horizontal])
                
                patrimonioCard(patrimonio: Patrimonio(id: 0, tags: ["Rural", "Descubre", "Patrimonio", "Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho más.", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
                    .padding(.horizontal)
                
                Rectangle()
                    .foregroundStyle(.quinary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .padding(.vertical, 12)
                
                ForEach(patrimonios, id: \.id) { patrimonio in
                    patrimonioCard(patrimonio: patrimonio)
                        .padding(.horizontal)
                        .onTapGesture {
                            router.navigate(to: .patrimonio(patrimonio: patrimonio))
                        }
                    
                    Rectangle()
                        .foregroundStyle(.quinary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 4)
                        .padding(.vertical, 12)
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .horizontal)
            .padding(.top, -8)
        }
        .padding(.horizontal, -16)
        .onAppear{
            if patrimonios.isEmpty {
                modelContext.insert(Patrimonio(id: 0, tags: ["Rural", "Descubre", "Patrimonio", "Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho más.", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
                
                modelContext.insert(Patrimonio(id: 1, tags: ["Patrimonio", "Descubre", "Hike", "Cultura", "Montaña"], persona: "Explorador de Raíces", personaFoto: "person2", estado: "Nuevo León", comunidad: "El Salto", titulo: "Cerro de la Silla", descripcion: "Sube al icónico cerro que vigila la ciudad de Monterrey y conecta con la historia y cultura local, mientras disfrutas de vistas impresionantes.", coordinates: [25.612250, -100.278030], ubicacion: "El Salto, Nuevo León", fotos: ["cerro1", "cerro2", "cerro3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 4))
                
                modelContext.insert(Patrimonio(id: 2, tags: ["Rural", "Descubre", "Patrimonio", "Aventura", "Agua", "Naturaleza"], persona: "Aventurero Silvestre", personaFoto: "person3", estado: "Nuevo León", comunidad: "Cieneguilla", titulo: "Río Pilón", descripcion: "Explora las cristalinas aguas del Río Pilón, un lugar perfecto para practicar senderismo y nadar en un entorno natural virgen.", coordinates: [25.343784, -99.891594], ubicacion: "Cieneguilla, Nuevo León", fotos: ["pilon1", "pilon2", "pilon3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
                
                modelContext.insert(Patrimonio(id: 3, tags: ["Rural", "Descubre", "Patrimonio", "Cultura", "Historia"], persona: "Historias del Norte", personaFoto: "person4", estado: "Nuevo León", comunidad: "Galeana", titulo: "La Poza de la Gloria", descripcion: "Visita este lugar lleno de historia, conocido por haber sido un refugio durante la Guerra de Reforma, rodeado de naturaleza.", coordinates: [24.836251, -100.104105], ubicacion: "Galeana, Nuevo León", fotos: ["poza1", "poza2", "poza3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 4))
                
                modelContext.insert(Patrimonio(id: 4, tags: ["Rural", "Descubre", "Patrimonio", "Aventura", "Cuevas", "Exploración"], persona: "Guía Subterráneo", personaFoto: "person5", estado: "Nuevo León", comunidad: "Bustamante", titulo: "Grutas de Bustamante", descripcion: "Adéntrate en las profundas y misteriosas grutas, un viaje subterráneo que te llevará a descubrir formaciones naturales increíbles.", coordinates: [26.540776, -100.499512], ubicacion: "Bustamante, Nuevo León", fotos: ["grutas1", "grutas2", "grutas3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
                
                modelContext.insert(Patrimonio(id: 5, tags: ["Rural", "Pueblo Mágico", "Descubre", "Patrimonio", "Cultura", "Tradición", "Rural"], persona: "Cronista Regional", personaFoto: "person6", estado: "Nuevo León", comunidad: "Aramberri", titulo: "Pueblo Mágico de Aramberri", descripcion: "Descubre las leyendas y tradiciones de este tranquilo pueblo, conocido por sus antiguas haciendas y artesanías tradicionales.", coordinates: [24.039659, -99.800330], ubicacion: "Aramberri, Nuevo León", fotos: ["aramberri1", "aramberri2", "aramberri3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 4))
                
                modelContext.insert(Patrimonio(id: 6, tags: ["Rural", "Patrimonio", "Aventura", "Escalada", "Montaña"], persona: "Escalador Extremo", personaFoto: "person7", estado: "Nuevo León", comunidad: "Potrero Chico", titulo: "Escalada en Potrero Chico", descripcion: "Disfruta de uno de los mejores sitios de escalada en México, donde los acantilados de roca caliza ofrecen retos únicos para todos los niveles.", coordinates: [25.964460, -100.455560], ubicacion: "Potrero Chico, Hidalgo", fotos: ["potrero1", "potrero2", "potrero3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
                
                modelContext.insert(Patrimonio(id: 7, tags: ["Rural", "Descubre", "Patrimonio", "Cultura", "Aventura", "Bosque"], persona: "Guardian de la Sierra", personaFoto: "person8", estado: "Nuevo León", comunidad: "Zaragoza", titulo: "Sierra de Zaragoza", descripcion: "Un lugar donde se mezclan la cultura indígena y la naturaleza salvaje, ideal para practicar senderismo en medio de exuberantes paisajes boscosos.", coordinates: [23.987345, -99.771441], ubicacion: "Zaragoza, Nuevo León", fotos: ["zaragoza1", "zaragoza2", "zaragoza3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 4))
                
                modelContext.insert(Patrimonio(id: 8, tags: ["Rural","Patrimonio", "Aventura", "Ciclismo", "Naturaleza"], persona: "Ciclista de la Montaña", personaFoto: "person2", estado: "Nuevo León", comunidad: "San José de las Boquillas", titulo: "Ruta Ciclista Montemorelos", descripcion: "Una travesía en bicicleta a través de los paisajes montañosos de Montemorelos, perfecta para los amantes del ciclismo de montaña.", coordinates: [25.198034, -99.828610], ubicacion: "San José de las Boquillas, Montemorelos", fotos: ["montemorelos1", "montemorelos2", "montemorelos3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
                
                modelContext.insert(Patrimonio(id: 9, tags: ["Rural", "Descubre", "Patrimonio", "Cultura", "Arqueología", "Montaña"], persona: "Arqueólogo del Norte", personaFoto: "person1", estado: "Nuevo León", comunidad: "Rayones", titulo: "Sitio Arqueológico El Sabinito", descripcion: "Explora este antiguo sitio arqueológico rodeado de montañas, testimonio de las primeras civilizaciones que habitaron el noreste de México.", coordinates: [25.180836, -100.195612], ubicacion: "Rayones, Nuevo León", fotos: ["sabinito1", "sabinito2", "sabinito3"], idioma: "Náhuatl", favorited: false, visited: true, estrella: 5))
            }
            if estados.isEmpty {
                modelContext.insert(Estado(id: 0, nombre: "Aguascalientes", icono: "Im1", fotos: ["AG1", "AG2", "AG3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 1, nombre: "Baja California", icono: "Im2", fotos: ["BC1", "BC2", "BC3"], ubicacion: "Noroeste de México"))
                modelContext.insert(Estado(id: 2, nombre: "Baja California Sur", icono: "Im3", fotos: ["BCS1", "BCS2", "BCS3"], ubicacion: "Noroeste de México"))
                modelContext.insert(Estado(id: 3, nombre: "Campeche", icono: "Im4", fotos: ["CAM1", "CAM2", "CAM3"], ubicacion: "Sureste de México"))
                modelContext.insert(Estado(id: 4, nombre: "Chiapas", icono: "Im5", fotos: ["CHIS1", "CHIS2", "CHIS3"], ubicacion: "Sureste de México"))
                modelContext.insert(Estado(id: 5, nombre: "Chihuahua", icono: "Im6", fotos: ["CHIH1", "CHIH2", "CHIH3"], ubicacion: "Noroeste de México"))
                modelContext.insert(Estado(id: 6, nombre: "Ciudad de México", icono: "Im7", fotos: ["CDMX1", "CDMX2", "CDMX3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 7, nombre: "Coahuila", icono: "Im8", fotos: ["COAH1", "COAH2", "COAH3"], ubicacion: "Noreste de México"))
                modelContext.insert(Estado(id: 8, nombre: "Colima", icono: "Im9", fotos: ["COL1", "COL2", "COL3"], ubicacion: "Oeste de México"))
                modelContext.insert(Estado(id: 9, nombre: "Durango", icono: "Im10", fotos: ["DUR1", "DUR2", "DUR3"], ubicacion: "Noroeste de México"))
                modelContext.insert(Estado(id: 10, nombre: "Guanajuato", icono: "Im12", fotos: ["GTO1", "GTO2", "GTO3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 11, nombre: "Guerrero", icono: "Im13", fotos: ["GRO1", "GRO2", "GRO3"], ubicacion: "Suroeste de México"))
                modelContext.insert(Estado(id: 12, nombre: "Hidalgo", icono: "Im14", fotos: ["HGO1", "HGO2", "HGO3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 13, nombre: "Jalisco", icono: "Im15", fotos: ["JAL1", "JAL2", "JAL3"], ubicacion: "Oeste de México"))
                modelContext.insert(Estado(id: 14, nombre: "Estado de México", icono: "Im11", fotos: ["MEX1", "MEX2", "MEX3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 15, nombre: "Michoacán", icono: "Im16", fotos: ["MICH1", "MICH2", "MICH3"], ubicacion: "Oeste de México"))
                modelContext.insert(Estado(id: 16, nombre: "Morelos", icono: "Im17", fotos: ["MOR1", "MOR2", "MOR3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 17, nombre: "Nayarit", icono: "Im18", fotos: ["NAY1", "NAY2", "NAY3"], ubicacion: "Oeste de México"))
                modelContext.insert(Estado(id: 18, nombre: "Nuevo León", icono: "Im19", fotos: ["NL1", "NL2", "NL3"], ubicacion: "Noreste de México"))
                modelContext.insert(Estado(id: 19, nombre: "Oaxaca", icono: "Im20", fotos: ["OAX1", "OAX2", "OAX3"], ubicacion: "Suroeste de México"))
                modelContext.insert(Estado(id: 20, nombre: "Puebla", icono: "Im21", fotos: ["PUE1", "PUE2", "PUE3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 21, nombre: "Querétaro", icono: "Im22", fotos: ["QRO1", "QRO2", "QRO3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 22, nombre: "Quintana Roo", icono: "Im23", fotos: ["QR1", "QR2", "QR3"], ubicacion: "Este de México"))
                modelContext.insert(Estado(id: 23, nombre: "San Luis Potosí", icono: "Im24", fotos: ["SLP1", "SLP2", "SLP3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 24, nombre: "Sinaloa", icono: "Im25", fotos: ["SIN1", "SIN2", "SIN3"], ubicacion: "Noroeste de México"))
                modelContext.insert(Estado(id: 25, nombre: "Sonora", icono: "Im26", fotos: ["SON1", "SON2", "SON3"], ubicacion: "Noroeste de México"))
                modelContext.insert(Estado(id: 26, nombre: "Tabasco", icono: "Im27", fotos: ["TAB1", "TAB2", "TAB3"], ubicacion: "Sureste de México"))
                modelContext.insert(Estado(id: 27, nombre: "Tamaulipas", icono: "Im28", fotos: ["TAM1", "TAM2", "TAM3"], ubicacion: "Noreste de México"))
                modelContext.insert(Estado(id: 28, nombre: "Tlaxcala", icono: "Im29", fotos: ["TLAX1", "TLAX2", "TLAX3"], ubicacion: "Centro de México"))
                modelContext.insert(Estado(id: 29, nombre: "Veracruz", icono: "Im30", fotos: ["VER1", "VER2", "VER3"], ubicacion: "Este de México"))
                modelContext.insert(Estado(id: 30, nombre: "Yucatán", icono: "Im31", fotos: ["YUC1", "YUC2", "YUC3"], ubicacion: "Sureste de México"))
                modelContext.insert(Estado(id: 31, nombre: "Zacatecas", icono: "Im32", fotos: ["ZAC1", "ZAC2", "ZAC3"], ubicacion: "Noroeste de México"))
            }
            if comunidades.isEmpty {
                modelContext.insert(Comunidad(id: 0, nombre: "Puerto Genovevo", fotos: ["PTGNV1", "PTGNV2", "PTGNV3"], estado: "Nuevo León", coordenadas: [25.343257560651292, -100.18272756559038]))
                modelContext.insert(Comunidad(id: 1, nombre: "El Salto", fotos: ["ELSALTO1", "ELSALTO2", "ELSALTO3"], estado: "Nuevo León", coordenadas: [26.323678145234513, -101.0439877115985]))
                modelContext.insert(Comunidad(id: 2, nombre: "Cieneguilla", fotos: ["CIE1", "CIE2", "CIE3"], estado: "Nuevo León", coordenadas: [25.37935678494486, -100.15195681612937]))
                modelContext.insert(Comunidad(id: 3, nombre: "Galeana", fotos: ["GALEANA1", "GALEANA2", "GALEANA3"], estado: "Nuevo León", coordenadas: [24.82547825503653, -100.07769750015227]))
                modelContext.insert(Comunidad(id: 4, nombre: "Bustamante", fotos: ["BUSTA1", "BUSTA2", "BUSTA3"], estado: "Nuevo León", coordenadas: [26.534367610402786, -100.50651927696958]))
                modelContext.insert(Comunidad(id: 5, nombre: "Aramberri", fotos: ["ARAM1", "ARAM2", "ARAM3"], estado: "Nuevo León", coordenadas: [24.097628780037155, -99.81518939865963]))
                modelContext.insert(Comunidad(id: 6, nombre: "Potrero Chico", fotos: ["POTRERO1", "POTRERO2", "POTRERO3"], estado: "Nuevo León", coordenadas: [25.963937337186337, -100.47709593551511]))
                modelContext.insert(Comunidad(id: 7, nombre: "Zaragoza", fotos: ["ZARAGOZA1", "ZARAGOZA2", "ZARAGOZA3"], estado: "Nuevo León", coordenadas: [25.674129217841557, -100.30943925589135]))
                modelContext.insert(Comunidad(id: 8, nombre: "San José de las Boquillas", fotos: ["SJB1", "SJB2", "SJB3"], estado: "Nuevo León", coordenadas: [25.362539560447466, -100.40612557730314]))
                modelContext.insert(Comunidad(id: 9, nombre: "Rayones", fotos: ["RAYONES1", "RAYONES2", "RAYONES3"], estado: "Nuevo León", coordenadas: [25.0164873020659, -100.07526277284744]))
            }
        }
    }
}

struct patrimonioCard: View {
    @StateObject private var transNahualtModel = TranslationNahualtModel()
    @StateObject private var transMayaModel = TranslationMayaModel()
    @State private var tagTranslations: [TagTranslations] = []
    @State private var selectedLanguage: String = "Español"
    
    var patrimonio: Patrimonio
    
    var body: some View {
        VStack {
            HStack {
                Image(patrimonio.personaFoto)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(patrimonio.persona)
                        .font(.custom(.raleway, style: .subheadline))
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("\(patrimonio.comunidad), ")
                            .font(.custom(.raleway, style: .footnote))
                            .fontWeight(.semibold)
                            .foregroundStyle(.rosaMex) +
                        Text(patrimonio.estado)
                            .font(.custom(.raleway, style: .footnote))
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.leading, 4)
                Spacer()
                Menu {
                    Button("Náhualt") { withAnimation{ selectedLanguage = "Nahualt" }}
                    Button("Maya") { withAnimation{ selectedLanguage = "Maya" }}
                    Button("Español") { withAnimation{ selectedLanguage = "Español" }}
                } label: {
                    Image(systemName: "globe")
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .offset(y: -2)
                }
            }
            
            if patrimonio.descripcion != "" {
                Text(patrimonio.descripcion)
                    .font(.custom(.raleway, style: .custom14))
                    .fontWeight(.medium)
                    .padding(.top, 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            TabView {
                ForEach(patrimonio.fotos, id: \.self) { foto in
                    Image(foto)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(height: 265)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .tabViewStyle(PageTabViewStyle())
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(tagTranslations, id: \.original) { tagTranslation in
                        HStack(spacing: 8) {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(.white)
                            Text(getTag(for: tagTranslation))
                                .foregroundStyle(.white)
                                .font(.custom(.raleway, style: .footnote))
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.tagColors[tagTranslation.original] ?? .rosaMex)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding([.top, .bottom], 4)
            
            HStack {
                Text(patrimonio.fecha.toSpanishFormattedString())
                    .font(.custom(.raleway, style: .caption))
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.top, 4)
        }
        .onAppear {
            setupTagTranslations()
        }
    }
    
    func getTag(for tagTranslation: TagTranslations) -> String {
        switch selectedLanguage {
        case "Nahualt":
            return tagTranslation.nahualt
        case "Maya":
            return tagTranslation.maya
        default:
            return tagTranslation.original
        }
    }
    
    func setupTagTranslations() {
        tagTranslations = patrimonio.tags.map { tag in
            TagTranslations(
                original: tag,
                nahualt: transNahualtModel.translate(tag.lowercased()).capitalized,
                maya: transMayaModel.translate(tag).capitalized
            )
        }
    }
}

#Preview {
    mainView()
}
