//
//  comunidadCard.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI

struct patrimonioEstadoCard:View {
    @EnvironmentObject var router: Router
    
    var patrimonio: Patrimonio
    
    var body: some View {
        VStack{
            ZStack{
                Image(patrimonio.fotos[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 224, height: 160)
                VStack{
                    Spacer()
                    HStack{
                        Image(patrimonio.personaFoto)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                        Text(patrimonio.persona)
                            .font(.custom(.raleway, style: .footnote))
                            .fontWeight(.semibold)
                        Spacer()
                        Text(patrimonio.idioma)
                            .font(.custom(.raleway, style: .caption))
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.init(top: 8, leading: 10, bottom: 10, trailing: 10))
                    .background(.white)
                }
            }
        }
        .frame(width: 224, height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.3), radius: 0.5, x: 0, y: 0.5)
        .onTapGesture {
            router.navigate(to: .patrimonio(patrimonio: patrimonio))
        }
    }
}

#Preview {
    patrimonioEstadoCard(patrimonio: Patrimonio(id: 4, tags: ["Rural", "Descubre", "Patrimonio", "Aventura", "Cuevas", "Exploración"], persona: "Guía Subterráneo", personaFoto: "person5", estado: "Nuevo León", comunidad: "Bustamante", titulo: "Grutas de Bustamante", descripcion: "Adéntrate en las profundas y misteriosas grutas, un viaje subterráneo que te llevará a descubrir formaciones naturales increíbles.", coordinates: [26.540776, -100.499512], ubicacion: "Bustamante, Nuevo León", fotos: ["grutas1", "grutas2", "grutas3"], idioma: "Náhuatl", favorited: false, visited: false, estrella: 5))
}
