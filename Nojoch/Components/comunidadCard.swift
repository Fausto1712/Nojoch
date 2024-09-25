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
                .overlay( RoundedRectangle(cornerRadius: 10) .stroke(.gray, lineWidth: 1))
            
            Text(comunidad.nombre)
                .font(.system(size: 20))
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 20)
        }
        .padding(.horizontal)
    }
}

#Preview {
    comunidadCard(comunidad: Comunidad(id: 0, nombre: "Puerto Genovevo", fotos: ["PTGNV1", "PTGNV2", "PTGNV3"], estado: "Nuevo León"))
}
