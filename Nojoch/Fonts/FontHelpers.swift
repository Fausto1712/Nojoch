//
//  FontHelpers.swift
//  Nojoch
//
//  Created by Axel Amós Hernández Cárdenas on 25/10/24.
//
import SwiftUI

// Declaración de Fuentes Custom
enum CustomFont: String {
    case poppinsBold = "Poppins-Bold"
    case poppinsSemiBold = "Poppins-SemiBold"
    case raleway = "Raleway"
}

// Estilos Predefinidos (Apple Size)
enum FontStyle {
    case largeTitle
    case title
    case title2
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption
    case custom14
    
    var size: CGFloat { // Regresa el size correcto
        switch self {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .headline: return 17
        case .subheadline: return 15
        case .body: return 17
        case .callout: return 16
        case .footnote: return 13
        case .caption: return 12
        case .custom14: return 14
 
        }
    }
}

// Extensión para facilitar el uso de las fuentes personalizadas con estilos predefinidos
extension Font {
    static func custom(_ font: CustomFont, style: FontStyle) -> Font {
        return Font.custom(font.rawValue, size: style.size)
    }
}
