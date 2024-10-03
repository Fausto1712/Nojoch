//
//  Extensions.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 02/10/24.
//

import Foundation

extension Date {
    func toSpanishFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
}
