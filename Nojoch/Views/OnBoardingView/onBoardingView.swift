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
            
            VStack(alignment: .leading){
                Text("Descubre")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                
                Text("comunidades")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundStyle(.rosaMex)
                
                HStack{
                    Text("Conoce lo que las comunidades tienen para ofrecer mediante posts en tu feed.")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .frame(width:362, height: 50)
            }
            
            patrimonioCard(patrimonio: Patrimonio(id: 0, tags: ["Rural", "Descubre", "Patrimonio", "Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
    }
}

struct thirdOnboardingView: View {
    @Query private var estados: [Estado]
    
    @Binding var pageState: Int
    
    var body: some View {
        VStack{
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
            
            VStack(alignment: .leading, spacing: 0){
                Text("Visita patrimonios")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                
                Text("únicos")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundStyle(.rosaMex)
                
                HStack{
                    Text("Conoce por estado y explora su patrimonio, naturaleza y comunidad.")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .frame(width:362, height: 50)
            }
            
            ForEach(estados.prefix(5), id: \.id) { estado in
                estadoCard(estado: estado)
                    .padding(.top, 5)
            }
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
    }
}

struct fourthOnboardingView: View {
    @Query private var estados: [Estado]
    @Binding var pageState: Int
    var body: some View {
        VStack{
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
            
            VStack(alignment: .leading, spacing: 0){
                Text("¿Listo para la")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                
                Text("aventura")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundStyle(.rosaMex)
                + Text("?")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                
                HStack{
                    Text("Comparte tu progreso al explorar las comunidades que México tiene para tí.")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .frame(width:362, height: 50)
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
