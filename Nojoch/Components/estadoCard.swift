//
//  estadoCard.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 20/10/24.
//

import SwiftUI

struct estadoCard:View {
    var estado: Estado
    var body: some View {
        HStack{
            Image(estado.icono)
                .resizable()
                .frame(width: 50, height: 50)
                .shadow(radius: 5)
            
            Text(estado.nombre)
                .font(.system(size: 20))
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 20)
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 3))
        .padding(.horizontal)
    }
}

#Preview {
    estadoCard(estado: Estado(id: 18, nombre: "Nuevo León", icono: "Im2", fotos: ["NL1", "NL2", "NL3"], ubicacion: "Norte de Mexico"))
}
