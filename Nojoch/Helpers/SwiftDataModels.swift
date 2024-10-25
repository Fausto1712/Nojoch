//
//  SwifDataModels.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftData
import SwiftUI

@Model
final class Patrimonio : Identifiable {
    var id: Int
    var tags: [String]
    var persona: String
    var personaFoto: String
    var estado: String
    var comunidad: String
    var titulo: String
    var descripcion: String
    var coordinates: [Double]
    var ubicacion:String
    var fotos: [String]
    var idioma: String
    var favorited: Bool
    var visited: Bool
    var estrella: Int
    var fecha: Date
    
    init(id: Int, tags: [String], persona: String, personaFoto: String, estado: String, comunidad: String, titulo: String, descripcion: String, coordinates: [Double], ubicacion:String, fotos: [String], idioma: String, favorited: Bool, visited: Bool, estrella: Int) {
        self.id = id
        self.tags = tags
        self.persona = persona
        self.personaFoto = personaFoto
        self.estado = estado
        self.comunidad = comunidad
        self.titulo = titulo
        self.descripcion = descripcion
        self.coordinates = coordinates
        self.ubicacion = ubicacion
        self.fotos = fotos
        self.idioma = idioma
        self.favorited = favorited
        self.visited = visited
        self.estrella = estrella
        self.fecha = Date()
    }
}

@Model
final class Estado : Identifiable {
    var id: Int
    var nombre: String
    var icono: String
    var fotos: [String]
    var ubicacion: String
    
    init(id: Int, nombre: String, icono: String, fotos: [String], ubicacion: String) {
        self.id = id
        self.nombre = nombre
        self.icono = icono
        self.fotos = fotos
        self.ubicacion = ubicacion
    }
}

@Model
final class Comunidad : Identifiable {
    var id: Int
    var nombre: String
    var fotos: [String]
    var estado: String
    var coordenadas: [Double]
    
    init(id: Int, nombre: String, fotos: [String], estado: String, coordenadas: [Double]) {
        self.id = id
        self.nombre = nombre
        self.fotos = fotos
        self.estado = estado
        self.coordenadas = coordenadas
    }
}

struct Category: Identifiable {
    var id: UUID
    var color: Color
    var chartValue: CGFloat
    var name: String
    
    init(color: Color, chartValue: CGFloat, name: String) {
        self.id = UUID()
        self.color = color
        self.chartValue = chartValue
        self.name = name
    }
}

extension Patrimonio {
    static var defaultEvent: Patrimonio {
        return Patrimonio(
            id: 0,
            tags: [],
            persona: "",
            personaFoto: "",
            estado: "",
            comunidad: "",
            titulo: "",
            descripcion: "",
            coordinates: [0,0],
            ubicacion: "",
            fotos: [],
            idioma: "",
            favorited: false,
            visited: false,
            estrella: 0
        )
    }
}
