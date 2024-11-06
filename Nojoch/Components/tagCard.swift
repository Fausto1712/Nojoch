//
//  comunidadCard.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI

struct tagCard:View {
    var tag: String
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack{
                    Text(tag)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.custom(.poppinsSemiBold, style: .caption))
                    Spacer()
                }
                Spacer()
            }
            .padding(8)
            
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(45))
                    .shadow(color: .black.opacity(0.3), radius: 0.7, x: -1, y: 2)
                
                Text(String.tagEmojis[tag] ?? "🌍")
                    .font(.title2)
            }
            .offset(x:45, y: 20)
        }
        .frame(width: 120, height: 70)
        .background(Color.tagColors[tag] ?? .rosaMex)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    tagCard(tag: "Descubre")
}
