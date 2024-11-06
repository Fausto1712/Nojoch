//
//  onBoardingView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData
import SceneKit

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
                .frame(maxWidth: .infinity, maxHeight: 51)
                .background(isFirst ? .darkPink : .rosaMex)
                .foregroundColor(.white)
                .font(.custom(.poppinsSemiBold, style: .callout))
                .fontWeight(.semibold)
                .cornerRadius(12)
                .padding(.top, 20)
                .accessibility(label: Text("Siguiente"))
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Spacer()
            
            VStack {
                
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
                                .offset(x: 75, y: -105)
                                .wiggleAnimation()
                        }
                        
                        if showImage3 {
                            Image("onboarding3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                                .offset(x: -80, y: 140)
                                .wiggleAnimation()
                        }
                        
                        if showImage4 {
                            Image("onboarding4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .offset(x: 100, y: 140)
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
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    VStack(alignment: .leading, spacing: 2){
                        Text("Bienvenido a\n")
                            .font(.custom(.poppinsBold, style: .largeTitle))
                            .foregroundStyle(.white) +
                        Text("Herencia Viva")
                            .foregroundStyle(.deepPink)
                            .font(.custom(.poppinsBold, style: .largeTitle))
                    }
                    .accessibility(label: Text("Bienvenido a Herencia Viva"))
                    
                    Text("Descubre los lugares más ocultos e impresionantes de México con nosotros.")
                        .foregroundStyle(.white)
                        .font(.custom(.raleway, style: .callout))
                        .fontWeight(.semibold)
                        .lineSpacing(4)
                        .accessibility(label: Text("Descubre los lugares más ocultos e impresionantes de México con nosotros."))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 72)
                
                
                continueButton(pageState: $pageState, isFirst: true)
            }
            .padding()
            .padding(.top, 36)
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
        }
        
        VStack(alignment: .leading){
            Text("Descubre")
                .font(.custom(.poppinsBold, style: .largeTitle))
                .accessibility(label: Text("Descubre"))
            Text("comunidades")
                .font(.custom(.poppinsBold, style: .largeTitle))
                .foregroundStyle(.rosaMex)
                .padding(.top, -36)
                .accessibility(label: Text("Comunidades"))
            
            
            Text("Conoce lo que las comunidades tienen \npara ofrecer mediante posts en tu feed.")
                .font(.custom(.raleway, style: .callout))
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .accessibility(label: Text("Conoce lo que las comunidades tienen \npara ofrecer mediante posts en tu feed."))
            
            patrimonioCard(patrimonio: Patrimonio(id: 0, tags: ["Rural", "Descubre", "Patrimonio", "Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
                .padding(.top, 12)
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
                .padding(.bottom, 36)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        
    }
}

struct thirdOnboardingView: View {
    @Query private var estados: [Estado]
    
    @Binding var pageState: Int
    
    var body: some View {
        
        VStack{
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
        }
        
        VStack{
            
            VStack (alignment: .leading){
                Text("Visita patrimonios")
                    .font(.custom(.poppinsBold, style: .largeTitle))
                    .accessibility(label: Text("Visita patrimonios"))
                
                
                Text("únicos")
                    .font(.custom(.poppinsBold, style: .largeTitle))
                    .foregroundStyle(.rosaMex)
                    .padding(.top, -36)
                    .accessibility(label: Text("únicos"))
                
                Text("Conoce por estado y explora su \npatrimonio, naturaleza y comunidad.")
                    .font(.custom(.raleway, style: .callout))
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .accessibility(label: Text("Conoce por estado y explora su \npatrimonio, naturaleza y comunidad."))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                ForEach(estados.prefix(5), id: \.id) { estado in
                    HStack {
                        Image(estado.icono)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 52, height: 52)
                            .shadow(color: .black.opacity(0.4), radius: 1)
                            .padding(.leading, 4)
                        
                        Text(estado.nombre)
                            .font(.custom(.raleway, style: .callout))
                            .fontWeight(.bold)
                            .padding(.leading, 8)
                        
                        Spacer()
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.25), radius: 1)
                    )
                    .padding(.bottom, 4)

                }
            }
            .padding(.top, 8)
            
            Spacer()
            
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
        .padding(.top, -4)
    }
}

struct fourthOnboardingView: View {
    @Query private var estados: [Estado]
    @Binding var pageState: Int
    
    var body: some View {
        VStack {
            HeaderAppViewOnboarding(pageState: pageState, isFirst: false)
        }
        
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                VStack{
                    Text("Alístate para \nla ")
                        .font(.custom(.poppinsBold, style: .largeTitle)) +
                    Text("aventura")
                        .font(.custom(.poppinsBold, style: .largeTitle))
                        .foregroundStyle(.rosaMex)
                }
                .accessibility(label: Text("Alistate para la aventura"))
                
                Text("Comparte tu progreso al explorar las comunidades que México tiene para tí.")
                    .font(.custom(.raleway, style: .callout))
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .accessibility(label: Text("Comparte tu progreso al explorar las comunidades que México tiene para tí."))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -4)
            
            Spacer()
            
            AlebrijeSceneView()
                .frame(height: 300)
            
            Spacer()
            continueButton(pageState: $pageState, isFirst: false)
        }
        .padding()
    }
}


struct AlebrijeSceneView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        let scene = SCNScene(named: "alebrije.usdz")
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.intensity = 1000
        ambientLightNode.light?.color = UIColor.white
        
        scene?.rootNode.addChildNode(lightNode)
        scene?.rootNode.addChildNode(ambientLightNode)
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .clear
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
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
