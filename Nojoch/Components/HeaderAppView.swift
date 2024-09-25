//
//  HeaderAppView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI

struct HeaderAppViewOnboarding: View {
    
    var body: some View {
        HStack{
            Image("person1")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .foregroundStyle(.gray.opacity(0.5))
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

struct HeaderAppView: View {
    var headerTitle: String
    var body: some View {
        VStack{
            HStack{
                Image("person1")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.gray.opacity(0.5))
                Text(headerTitle)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                Spacer()
            }
            Divider()
                .background(Color.gray.opacity(0.5))
                .padding(.horizontal, -16)
        }
    }
}

struct HeaderAppViewComponent: View {
    @EnvironmentObject var router: Router
    var body: some View {
        VStack{
            HStack{
                Button{
                    router.navigateBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundStyle(.black)
                        .frame(width: 10, height: 20)
                }
                
                Spacer()
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Divider()
                .background(Color.gray.opacity(0.5))
                .padding(.horizontal, -16)
        }
    }
}

#Preview {
    //HeaderAppView(headerTitle: "Herencia Viva")
    HeaderAppViewComponent()
}
