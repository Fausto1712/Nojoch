//
//  Extensions.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 02/10/24.
//

import Foundation
import SwiftUI

extension Date {
    func toSpanishFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
}

extension Color {
    static let tagColors: [String: Color] = [
        "Patrimonio": .rosaMex,
        "Pueblo Mágico": .rosaMex,
        "Rural": .green,
        "Descubre": .turquoise,
        "Naturaleza": .green,
        "Montaña": .gray,
        "Cuevas": .brown,
        "Agua": .blue,
        "Escalada": .red,
        "Aventura": .orange,
        "Exploración": .yellow,
        "Arqueología": Color.yellow.opacity(0.6),
        "Bosque": Color.green.opacity(0.8),
        "Hike": Color.green.opacity(0.5),
        "Tradición": Color.purple,
        "Ciclismo": Color.cyan,
        "Historia": Color.yellow.opacity(0.9)
    ]
}

extension String {
    static let tagEmojis: [String: String] = [
        "Patrimonio": "🏛️",
        "Pueblo Mágico": "🌸",
        "Rural": "🌾",
        "Descubre": "🌍",
        "Naturaleza": "🌿",
        "Montaña": "🏔️",
        "Cuevas": "🕳️",
        "Agua": "💧",
        "Escalada": "🧗",
        "Aventura": "🚵",
        "Exploración": "🔍",
        "Arqueología": "⚒️",
        "Bosque": "🌲",
        "Hike": "🥾",
        "Tradición": "🎎",
        "Ciclismo": "🚴",
        "Historia": "📜"
    ]
}
