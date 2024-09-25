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
                        Label("Main", systemImage: "house.fill")
                    }
                
                exploreView()
                    .tabItem {
                        Label("Explora", systemImage: "field.of.view.ultrawide")
                    }
                
                miHerenciaView()
                    .tabItem {
                        Label("Mi herencia", systemImage: "bubble")
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
