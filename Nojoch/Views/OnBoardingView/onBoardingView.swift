//
//  onBoardingView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct onBoardingView: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @State var pageState: Int = 0
    
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var patrimonios: [Patrimonio]
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    
    var body: some View {
        VStack{
            if pageState == 0 {
                firstOnboardingView(pageState: $pageState)
            } else if pageState == 1 {
                secondOnboardingView(pageState: $pageState)
            } else if pageState == 2 {
                thirdOnboardingView(pageState: $pageState)
            } else if pageState == 3 {
                fourthOnboardingView(pageState: $pageState)
            }
        }
        .navigationBarBackButtonHidden()
        .onChange(of: pageState){
            if pageState == 4 {
                isOnboardingCompleted = true
                
                if patrimonios.isEmpty {
                    modelContext.insert(Patrimonio(id: 0, tags: ["Rural", "Descubre", "Patrimonio", "Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho mas", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
                    
                    modelContext.insert(Patrimonio(id: 1, tags: ["Patrimonio", "Descubre", "Hike", "Cultura", "Montaña"], persona: "Explorador de Raíces", personaFoto: "person2", estado: "Nuevo León", comunidad: "El Salto", titulo: "Cerro de la Silla", descripcion: "Sube al icónico cerro que vigila la ciudad de Monterrey y conecta con la historia y cultura local, mientras disfrutas de vistas impresionantes.", coordinates: [25.612250, -100.278030], ubicacion: "El Salto, Nuevo León", fotos: ["cerro1", "cerro2", "cerro3"], idioma: "Huasteco", favorited: false, visited: false, estrella: 4))
                    
                    modelContext.insert(Patrimonio(id: 2, tags: ["Rural", "Descubre", "Patrimonio", "Aventura", "Agua", "Naturaleza"], persona: "Aventurero Silvestre", personaFoto: "person3", estado: "Nuevo León", comunidad: "Cieneguilla", titulo: "Río Pilón", descripcion: "Explora las cristalinas aguas del Río Pilón, un lugar perfecto para practicar senderismo y nadar en un entorno natural virgen.", coordinates: [25.343784, -99.891594], ubicacion: "Cieneguilla, Nuevo León", fotos: ["pilon1", "pilon2", "pilon3"], idioma: "Otomí", favorited: false, visited: false, estrella: 5))
                    
                    modelContext.insert(Patrimonio(id: 3, tags: ["Rural", "Descubre", "Patrimonio", "Cultura", "Historia", "Rural"], persona: "Historias del Norte", personaFoto: "person4", estado: "Nuevo León", comunidad: "Galeana", titulo: "La Poza de la Gloria", descripcion: "Visita este lugar lleno de historia, conocido por haber sido un refugio durante la Guerra de Reforma, rodeado de naturaleza.", coordinates: [24.836251, -100.104105], ubicacion: "Galeana, Nuevo León", fotos: ["poza1", "poza2", "poza3"], idioma: "Totonaco", favorited: false, visited: false, estrella: 4))
                    
                    modelContext.insert(Patrimonio(id: 4, tags: ["Rural", "Descubre", "Patrimonio", "Aventura", "Cuevas", "Exploración"], persona: "Guía Subterráneo", personaFoto: "person5", estado: "Nuevo León", comunidad: "Bustamante", titulo: "Grutas de Bustamante", descripcion: "Adéntrate en las profundas y misteriosas grutas, un viaje subterráneo que te llevará a descubrir formaciones naturales increíbles.", coordinates: [26.540776, -100.499512], ubicacion: "Bustamante, Nuevo León", fotos: ["grutas1", "grutas2", "grutas3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
                    
                    modelContext.insert(Patrimonio(id: 5, tags: ["Rural", "Pueblo Mágico", "Descubre", "Patrimonio", "Cultura", "Tradición", "Rural"], persona: "Cronista Regional", personaFoto: "person6", estado: "Nuevo León", comunidad: "Aramberri", titulo: "Pueblo Mágico de Aramberri", descripcion: "Descubre las leyendas y tradiciones de este tranquilo pueblo, conocido por sus antiguas haciendas y artesanías tradicionales.", coordinates: [24.039659, -99.800330], ubicacion: "Aramberri, Nuevo León", fotos: ["aramberri1", "aramberri2", "aramberri3"], idioma: "Huichol", favorited: false, visited: false, estrella: 4))
                    
                    modelContext.insert(Patrimonio(id: 6, tags: ["Rural", "Patrimonio", "Aventura", "Escalada", "Montaña"], persona: "Escalador Extremo", personaFoto: "person7", estado: "Nuevo León", comunidad: "Potrero Chico", titulo: "Escalada en Potrero Chico", descripcion: "Disfruta de uno de los mejores sitios de escalada en México, donde los acantilados de roca caliza ofrecen retos únicos para todos los niveles.", coordinates: [25.964460, -100.455560], ubicacion: "Potrero Chico, Hidalgo", fotos: ["potrero1", "potrero2", "potrero3"], idioma: "Totonaco", favorited: false, visited: false, estrella: 5))
                    
                    modelContext.insert(Patrimonio(id: 7, tags: ["Rural", "Descubre", "Patrimonio", "Cultura", "Aventura", "Bosque"], persona: "Guardian de la Sierra", personaFoto: "person8", estado: "Nuevo León", comunidad: "Zaragoza", titulo: "Sierra de Zaragoza", descripcion: "Un lugar donde se mezclan la cultura indígena y la naturaleza salvaje, ideal para practicar senderismo en medio de exuberantes paisajes boscosos.", coordinates: [23.987345, -99.771441], ubicacion: "Zaragoza, Nuevo León", fotos: ["zaragoza1", "zaragoza2", "zaragoza3"], idioma: "Maya", favorited: false, visited: false, estrella: 4))
                    
                    modelContext.insert(Patrimonio(id: 8, tags: ["Rural","Patrimonio", "Aventura", "Ciclismo", "Naturaleza"], persona: "Ciclista de la Montaña", personaFoto: "person2", estado: "Nuevo León", comunidad: "San José de las Boquillas", titulo: "Ruta Ciclista Montemorelos", descripcion: "Una travesía en bicicleta a través de los paisajes montañosos de Montemorelos, perfecta para los amantes del ciclismo de montaña.", coordinates: [25.198034, -99.828610], ubicacion: "San José de las Boquillas, Montemorelos", fotos: ["montemorelos1", "montemorelos2", "montemorelos3"], idioma: "Purépecha", favorited: false, visited: false, estrella: 5))
                    
                    modelContext.insert(Patrimonio(id: 9, tags: ["Rural", "Descubre", "Patrimonio", "Cultura", "Arqueología", "Montaña"], persona: "Arqueólogo del Norte", personaFoto: "person1", estado: "Nuevo León", comunidad: "Rayones", titulo: "Sitio Arqueológico El Sabinito", descripcion: "Explora este antiguo sitio arqueológico rodeado de montañas, testimonio de las primeras civilizaciones que habitaron el noreste de México.", coordinates: [25.180836, -100.195612], ubicacion: "Rayones, Nuevo León", fotos: ["sabinito1", "sabinito2", "sabinito3"], idioma: "Nahuatl", favorited: false, visited: false, estrella: 5))
                }
                if estados.isEmpty {
                    modelContext.insert(Estado(id: 0, nombre: "Aguascalientes", fotos: ["AG1", "AG2", "AG3"]))
                    modelContext.insert(Estado(id: 1, nombre: "Baja California", fotos: ["BC1", "BC2", "BC3"]))
                    modelContext.insert(Estado(id: 2, nombre: "Baja California Sur", fotos: ["BCS1", "BCS2", "BCS3"]))
                    modelContext.insert(Estado(id: 3, nombre: "Campeche", fotos: ["CAM1", "CAM2", "CAM3"]))
                    modelContext.insert(Estado(id: 4, nombre: "Chiapas", fotos: ["CHIS1", "CHIS2", "CHIS3"]))
                    modelContext.insert(Estado(id: 5, nombre: "Chihuahua", fotos: ["CHIH1", "CHIH2", "CHIH3"]))
                    modelContext.insert(Estado(id: 6, nombre: "Ciudad de México", fotos: ["CDMX1", "CDMX2", "CDMX3"]))
                    modelContext.insert(Estado(id: 7, nombre: "Coahuila", fotos: ["COAH1", "COAH2", "COAH3"]))
                    modelContext.insert(Estado(id: 8, nombre: "Colima", fotos: ["COL1", "COL2", "COL3"]))
                    modelContext.insert(Estado(id: 9, nombre: "Durango", fotos: ["DUR1", "DUR2", "DUR3"]))
                    modelContext.insert(Estado(id: 10, nombre: "Guanajuato", fotos: ["GTO1", "GTO2", "GTO3"]))
                    modelContext.insert(Estado(id: 11, nombre: "Guerrero", fotos: ["GRO1", "GRO2", "GRO3"]))
                    modelContext.insert(Estado(id: 12, nombre: "Hidalgo", fotos: ["HGO1", "HGO2", "HGO3"]))
                    modelContext.insert(Estado(id: 13, nombre: "Jalisco", fotos: ["JAL1", "JAL2", "JAL3"]))
                    modelContext.insert(Estado(id: 14, nombre: "Estado de México", fotos: ["MEX1", "MEX2", "MEX3"]))
                    modelContext.insert(Estado(id: 15, nombre: "Michoacán", fotos: ["MICH1", "MICH2", "MICH3"]))
                    modelContext.insert(Estado(id: 16, nombre: "Morelos", fotos: ["MOR1", "MOR2", "MOR3"]))
                    modelContext.insert(Estado(id: 17, nombre: "Nayarit", fotos: ["NAY1", "NAY2", "NAY3"]))
                    modelContext.insert(Estado(id: 18, nombre: "Nuevo León", fotos: ["NL1", "NL2", "NL3"]))
                    modelContext.insert(Estado(id: 19, nombre: "Oaxaca", fotos: ["OAX1", "OAX2", "OAX3"]))
                    modelContext.insert(Estado(id: 20, nombre: "Puebla", fotos: ["PUE1", "PUE2", "PUE3"]))
                    modelContext.insert(Estado(id: 21, nombre: "Querétaro", fotos: ["QRO1", "QRO2", "QRO3"]))
                    modelContext.insert(Estado(id: 22, nombre: "Quintana Roo", fotos: ["QR1", "QR2", "QR3"]))
                    modelContext.insert(Estado(id: 23, nombre: "San Luis Potosí", fotos: ["SLP1", "SLP2", "SLP3"]))
                    modelContext.insert(Estado(id: 24, nombre: "Sinaloa", fotos: ["SIN1", "SIN2", "SIN3"]))
                    modelContext.insert(Estado(id: 25, nombre: "Sonora", fotos: ["SON1", "SON2", "SON3"]))
                    modelContext.insert(Estado(id: 26, nombre: "Tabasco", fotos: ["TAB1", "TAB2", "TAB3"]))
                    modelContext.insert(Estado(id: 27, nombre: "Tamaulipas", fotos: ["TAM1", "TAM2", "TAM3"]))
                    modelContext.insert(Estado(id: 28, nombre: "Tlaxcala", fotos: ["TLAX1", "TLAX2", "TLAX3"]))
                    modelContext.insert(Estado(id: 29, nombre: "Veracruz", fotos: ["VER1", "VER2", "VER3"]))
                    modelContext.insert(Estado(id: 30, nombre: "Yucatán", fotos: ["YUC1", "YUC2", "YUC3"]))
                    modelContext.insert(Estado(id: 31, nombre: "Zacatecas", fotos: ["ZAC1", "ZAC2", "ZAC3"]))
                }
                if comunidades.isEmpty {
                    modelContext.insert(Comunidad(id: 0, nombre: "Puerto Genovevo", fotos: ["PTGNV1", "PTGNV2", "PTGNV3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 1, nombre: "El Salto", fotos: ["ELSALTO1", "ELSALTO2", "ELSALTO3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 2, nombre: "Cieneguilla", fotos: ["CIE1", "CIE2", "CIE3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 3, nombre: "Galeana", fotos: ["GALEANA1", "GALEANA2", "GALEANA3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 4, nombre: "Bustamante", fotos: ["BUSTA1", "BUSTA2", "BUSTA3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 5, nombre: "Aramberri", fotos: ["ARAM1", "ARAM2", "ARAM3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 6, nombre: "Potrero Chico", fotos: ["POTRERO1", "POTRERO2", "POTRERO3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 7, nombre: "Zaragoza", fotos: ["ZARAGOZA1", "ZARAGOZA2", "ZARAGOZA3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 8, nombre: "San José de las Boquillas", fotos: ["SJB1", "SJB2", "SJB3"], estado: "Nuevo León"))
                    modelContext.insert(Comunidad(id: 9, nombre: "Rayones", fotos: ["RAYONES1", "RAYONES2", "RAYONES3"], estado: "Nuevo León"))
                }
                
                router.setPath([.contentView])
            }
        }
    }
}

struct continueButton: View {
    @Binding var pageState: Int
    var isFirst: Bool
    var body: some View {
        Button{
            pageState += 1
        } label: {
            Text("Siguiente")
                .frame(width: 350, height: 50)
                .background(isFirst ? .darkPink : .rosaMex)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, 45)
        }
    }
}

struct firstOnboardingView: View {
    @Binding var pageState: Int
    
    @State private var showImage1 = false
    @State private var showImage2 = false
    @State private var showImage3 = false
    @State private var showImage4 = false
    
    var body: some View {
        ZStack {
            Color.rosaMex.ignoresSafeArea()
            VStack {
                HeaderAppViewOnboarding(pageState: pageState, isFirst: true)
                
                Spacer()
                
                VStack {
                    ZStack {
                        if showImage1 {
                            Image("onboarding1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                                .offset(x: -80, y: -50)
                                .wiggleAnimation()
                        }
                        
                        if showImage2 {
                            Image("onboarding2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                                .offset(x: 75, y: -65)
                                .wiggleAnimation()
                        }
                        
                        if showImage3 {
                            Image("onboarding3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                                .offset(x: -80, y: 170)
                                .wiggleAnimation()
                        }
                        
                        if showImage4 {
                            Image("onboarding4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .offset(x: 105, y: 150)
                                .wiggleAnimation()
                        }
                    }
                    .frame(height: 350)
                    .onAppear {
                        showImage1WithAnimation(after: 0)
                        showImage2WithAnimation(after: 0.3)
                        showImage3WithAnimation(after: 0.6)
                        showImage4WithAnimation(after: 0.9)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Bienvenido a")
                            .font(.system(size: 34))
                            .fontWeight(.bold)
                            .foregroundStyle(.white) +
                        Text(" Herencia Viva")
                            .foregroundStyle(.deepPink)
                            .font(.system(size: 34))
                            .fontWeight(.bold)
                        
                        Text("Descubre los lugares más ocultos e impresionantes de México con nosotros.")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                    }
                    .offset(x: -20)
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    continueButton(pageState: $pageState, isFirst: true)
                }
            }
            .padding()
        }
    }
    
    // Function to trigger haptic feedback
    func triggerHapticFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    // Functions to show images with animations
    private func showImage1WithAnimation(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                showImage1 = true
                triggerHapticFeedback()
            }
        }
    }
    
    private func showImage2WithAnimation(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                showImage2 = true
                triggerHapticFeedback()
            }
        }
    }
    
    private func showImage3WithAnimation(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                showImage3 = true
                triggerHapticFeedback()
            }
        }
    }
    
    private func showImage4WithAnimation(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                showImage4 = true
                triggerHapticFeedback()
            }
        }
    }
}
struct secondOnboardingView: View {
    @Binding var pageState: Int
    var body: some View {
        VStack{
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
            
            VStack{
                HStack{
                    Text("Explora el patrimonio MX")
                        .font(.system(size: 25))
                    Spacer()
                }
                
                HStack{
                    Text("Descripcion")
                        .font(.system(size: 20))
                    Spacer()
                }
            }
            .padding(.horizontal,30)
            .padding(.bottom)
            
            VStack{
                HStack{
                    Circle()
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(width: 40, height: 40)
                    Text("Lorem Ipsum")
                    Spacer()
                    Text("Ciudad, Estado")
                }
                Text("Descripcion de patrimonio de la comunidad")
                
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 300, height: 250)
                
                HStack(spacing: 15){
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 90, height: 25)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 90, height: 25)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 90, height: 25)
                }
                .frame(width: 300)
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 15){
                Circle()
                    .foregroundStyle(.gray)
                    .frame(width: 15, height: 15)
                Circle()
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(width: 15, height: 15)
                Circle()
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(width: 15, height: 15)
            }
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
    }
}

struct thirdOnboardingView: View {
    @Binding var pageState: Int
    var body: some View {
        VStack{
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
            
            VStack{
                HStack{
                    Text("Descubre a las Comunidades Rurales")
                        .font(.system(size: 25))
                    Spacer()
                }
                
                HStack{
                    Text("Descripcion")
                        .font(.system(size: 20))
                    Spacer()
                }
            }
            .padding(.horizontal,30)
            .padding(.bottom)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 250)
                .foregroundStyle(.gray.opacity(0.5))
                .padding(.bottom,30)
            
            HStack(spacing: 45){
                VStack{
                    Circle()
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(width: 65, height: 65)
                    Text("Award-1")
                }
                
                VStack{
                    Circle()
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(width: 65, height: 65)
                    Text("Award-2")
                }
                
                VStack{
                    Circle()
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(width: 65, height: 65)
                    Text("Award-3")
                }
            }
            .padding(.bottom,20)
            
            HStack(spacing: 15){
                Circle()
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(width: 15, height: 15)
                Circle()
                    .foregroundStyle(.gray)
                    .frame(width: 15, height: 15)
                Circle()
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(width: 15, height: 15)
            }
            .padding(.bottom,20)
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
    }
}

struct fourthOnboardingView: View {
    @Binding var pageState: Int
    var body: some View {
        VStack{
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
            
            Spacer()
            
            VStack{
                HStack{
                    Circle()
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(width: 40, height: 40)
                    Text("Team Nojoch")
                    Spacer()
                    Text("Ciudad, Estado")
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 300, height: 250)
                
                HStack(spacing: 15){
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 90, height: 25)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 90, height: 25)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 90, height: 25)
                }
                .frame(width: 300)
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 15){
                Circle()
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(width: 15, height: 15)
                Circle()
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(width: 15, height: 15)
                Circle()
                    .foregroundStyle(.gray)
                    .frame(width: 15, height: 15)
            }
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
    }
}

extension View {
    func wiggleAnimation() -> some View {
        self
            .rotationEffect(.degrees(Double.random(in: -5...5)))
            .scaleEffect(1.05)
            .animation(Animation.easeInOut(duration: 2.5).repeatCount(15, autoreverses: true), value: UUID())
    }
}

#Preview {
    onBoardingView()
}
