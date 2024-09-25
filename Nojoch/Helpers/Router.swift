//
//  Router.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 05/09/24.
//
import Foundation
import SwiftUI
import MapKit


final class Router: ObservableObject {
    public enum Destination: Hashable {
        //On boarding Screens
        case onboarding
        
        //Main screens
        case contentView
        case mainView
        case exploreView
        case miHerenciaView
        
        //Information Screens
        case patrimonio(patrimonio: Patrimonio)
        case estadoView(estado: Estado)
        case comunidadView(comunidad: Comunidad)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func setPath(_ newPath: [Destination]) {
        navPath = NavigationPath(newPath)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
