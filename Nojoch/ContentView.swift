//
//  ContentView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false

    var body: some View {
        if isOnboardingCompleted {
            TabView {
                mainView()
                    .tabItem {
                        Label("Inicio", systemImage: "house.fill")
                    }
                
                exploreView()
                    .tabItem {
                        Label("Explora", systemImage: "binoculars")
                    }
                
                miHerenciaView()
                    .tabItem {
                        Label("Herencia", systemImage: "medal")
                    }
                
                BadgesView()
                    .tabItem {
                        Label("Badges", systemImage: "trophy")
                    }

            }
            .navigationBarBackButtonHidden(true)
        } else {
            onBoardingView()
        }
    }
}

#Preview {
    ContentView()
}
