//
//  ContentView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack{
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
                    
                }
                .navigationBarBackButtonHidden(true)
            } else {
                onBoardingView()
            }
        }
        .onAppear {
            locationManager.camera = .region(MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 40.8525139681341, longitude: 14.272090640839773), latitudinalMeters: 5000, longitudinalMeters: 15000))
        }
    }
}

#Preview {
    ContentView()
}
