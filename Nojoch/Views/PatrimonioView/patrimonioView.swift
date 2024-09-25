//
//  patrimonioView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI

struct patrimonioView: View {
    @State var patrimonio: Patrimonio
    var body: some View {
        Text("PatrimonioView")
    }
}

#Preview {
    patrimonioView(patrimonio: Patrimonio(id: 0, tags: ["Hike", "Aventura", "Agua"], persona: "La Cumbre Cotidiana", personaFoto: "person5", estado: "Nuevo León", comunidad: "Puerto Genovevo", titulo: "Cañon Matacanes", descripcion: "Embarcate en una aventura extrema en uno de los cañones mas famosos de Mexico, con saltos de mas 12 metros, toboganes de agua, espeologia y mucho mas", coordinates: [25.371573866134465, -100.15547982938328], ubicacion: "Cola de caballo", fotos: ["matacanes1", "matacanes2", "matacanes3"], idioma: "Náhuatl", favorited: false, visited: false, esterellas: 5))
}
