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
    var esterellas: Int
    
    init(id: Int, tags: [String], persona: String, personaFoto: String, estado: String, comunidad: String, titulo: String, descripcion: String, coordinates: [Double], ubicacion:String, fotos: [String], idioma: String, favorited: Bool, visited: Bool, esterellas: Int) {
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
        self.esterellas = esterellas
    }
}

@Model
final class Estado : Identifiable {
    var id: Int
    var nombre: String
    var fotos: [String]
    
    init(id: Int, nombre: String, fotos: [String]) {
        self.id = id
        self.nombre = nombre
        self.fotos = fotos
    }
}

@Model
final class Comunidad : Identifiable {
    var id: Int
    var nombre: String
    var fotos: [String]
    var estado: String
    
    init(id: Int, nombre: String, fotos: [String], estado: String) {
        self.id = id
        self.nombre = nombre
        self.fotos = fotos
        self.estado = estado
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
            esterellas: 0
        )
    }
}
