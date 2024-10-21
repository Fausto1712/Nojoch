//
//  comunidadCard.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI

struct comunidadCard:View {
    var comunidad: Comunidad
    var body: some View {
        HStack{
            Image(comunidad.fotos[0])
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading){
                Text(comunidad.nombre)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Text(comunidad.estado)
                    .font(.system(size: 16))
                    .fontWeight(.light)
            }
            
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
    comunidadCard(comunidad: Comunidad(id: 0, nombre: "Puerto Genovevo", fotos: ["PTGNV1", "PTGNV2", "PTGNV3"], estado: "Nuevo León", coordenadas: [25.343257560651292, -100.18272756559038]))
}
