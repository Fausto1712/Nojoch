//
//  mainView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct mainView: View {
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var modelContext
    @Query private var patrimonios: [Patrimonio]
    
    var body: some View {
        VStack(alignment: .leading){
            HeaderAppView(headerTitle: "Herencia Viva")
            
            ScrollView{
                HStack{
                    Text("Patrimonios")
                        .foregroundStyle(.rosaMex)
                        .font(.system(size: 17))
                        .fontWeight(.semibold) +
                    Text(" de hoy")
                        .font(.system(size: 17))
                    Spacer()
                }
                
                ForEach(patrimonios, id: \.id) { patrimonio in
                    patrimonioCard(patrimonio: patrimonio)
                        .padding(.bottom)
                }
            }.scrollIndicators(.hidden)
        }
        .padding(.horizontal, 30)
    }
}

struct patrimonioCard: View {
    var patrimonio: Patrimonio
    var colors: [Color] = [.rosaMex, .turquoise, .mustard, .darkTeal, .deepBlue]
    let tagColors: [String: Color] = ["Patrimonio": .rosaMex, "Pueblo Mágico": .rosaMex, "Rural": .green, "Descubre": .turquoise, "Naturaleza": .green ]
    var body: some View {
        VStack{
            HStack{
                Image(patrimonio.personaFoto)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text(patrimonio.persona)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    
                    HStack{
                        Text("\(patrimonio.comunidad),")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.rosaMex)
                        
                        Text(patrimonio.estado)
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray.opacity(0.8))
                    }
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundStyle(.gray.opacity(0.8))
                    .fontWeight(.bold)
            }
            .padding(.vertical, 10)
            
            Text(patrimonio.descripcion)
                .font(.system(size: 15))
                .frame(width: 350, alignment: .leading)
            
            TabView {
                ForEach(patrimonio.fotos, id: \.self) { foto in
                    Image(foto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .clipped()
                }
            }
            .frame(width: 350, height: 250)
            .tabViewStyle(PageTabViewStyle())
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(patrimonio.tags, id: \.self) { tag in
                        HStack(spacing: 10){
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(.white)
                            Text(tag)
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(tagColors[tag] ?? colors.randomElement())
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
            .padding(.top, 5)
            Text(patrimonio.fecha.toSpanishFormattedString())
                .font(.system(size: 12))
                .foregroundStyle(.gray.opacity(0.8))
        }
    }
}

#Preview {
    mainView()
}
