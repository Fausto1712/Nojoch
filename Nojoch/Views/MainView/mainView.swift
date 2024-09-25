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
                    Text("Patrimonios de hoy")
                        .font(.system(size: 20))
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
    var body: some View {
        VStack{
            HStack{
                Image(patrimonio.personaFoto)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(patrimonio.persona)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                Spacer()
                Text("\(patrimonio.comunidad),")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                Text(patrimonio.estado)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
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
            
            HStack(spacing: 25){
                ForEach(patrimonio.tags, id: \.self) { tag in
                    Text(tag)
                        .frame(width: 100, height: 35)
                        .overlay{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                        }
                }
            }
            .frame(width: 300)
        }
    }
}

#Preview {
    mainView()
}
