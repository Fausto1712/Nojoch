//
//  NojochApp.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 19/09/24.
//

import SwiftUI
import SwiftData

@main
struct NojochApp: App {
    @ObservedObject var router = Router()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Patrimonio.self,
            Estado.self,
            Comunidad.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        //On boarding Screens
                        case .onboarding:
                            onBoardingView()
                            
                        //Main screens
                        case .contentView:
                            ContentView()
                        case .mainView:
                            mainView()
                        case .exploreView:
                            exploreView()
                        case .miHerenciaView:
                            miHerenciaView()
                            
                        //Information Screens
                        case .patrimonio(let patrimonio):
                            patrimonioView(patrimonio: patrimonio)
                        case .estadoView(let estado):
                            estadoView(estado: estado)
                        case .comunidadView(let comunidad):
                            comunidadView(comunidad: comunidad)
                        }
                    }
            }
        }
        .environmentObject(router)
        .modelContainer(sharedModelContainer)
    }
}
