//
//  NahualtText.swift
//  Nojoch
//
//  Created by Tlanetzi Chavez Madero on 04/11/24.
//

import CoreML
import SwiftUI

class TranslationNahualtModel: ObservableObject {
    private var model: NahualtClass?

    init() {
        model = try? NahualtClass(configuration: MLModelConfiguration())
    }
    func translate(_ text: String) -> String {
        guard let model = model else {
            return "Error al cargar el modelo"
        }
        
        if let prediction = try? model.prediction(text: text) {
            return prediction.label
        } else {
            return "Error en la predicción"
        }
    }
}


class TranslationMayaModel: ObservableObject {
    private var model: MayaClass?

    init() {
        model = try? MayaClass(configuration: MLModelConfiguration())
    }
    func translate(_ text: String) -> String {
        guard let model = model else {
            return "Error al cargar el modelo"
        }
        
        if let prediction = try? model.prediction(text: text) {
            return prediction.label
        } else {
            return "Error en la predicción"
        }
    }
}


