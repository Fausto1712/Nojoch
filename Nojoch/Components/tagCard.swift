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
                        .font(.system(size: 12))
                    Spacer()
                }
                Spacer()
            }
            .padding(5)
            
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(45))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 5)
                
                Text(String.tagEmojis[tag] ?? "🌍")
                    .font(.system(size: 25))
            }
            .offset(x:30, y: 15)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
        }
        .frame(width: 100, height: 60)
        .background(Color.tagColors[tag] ?? .rosaMex)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    tagCard(tag: "Descubre")
}
