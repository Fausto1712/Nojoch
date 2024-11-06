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
                .aspectRatio(contentMode: .fit)
                .frame(width: 52, height: 52)
                .shadow(color: .black.opacity(0.4), radius: 1)
                .padding(.leading, 4)
            
            Text(estado.nombre)
                .font(.custom(.raleway, style: .callout))
                .fontWeight(.bold)
                .padding(.leading, 8)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
                .frame(width: 10, height: 20)
                .padding(.trailing, 4)
        }
        //.padding(.bottom, 4)
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: .black.opacity(0.25), radius: 1))
        .padding(.horizontal)
    }
}

#Preview {
    estadoCard(estado: Estado(id: 18, nombre: "Nuevo León", icono: "Im2", fotos: ["NL1", "NL2", "NL3"], ubicacion: "Norte de Mexico"))
}
