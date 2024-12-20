//
//  HeaderAppView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct HeaderAppViewOnboarding: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var modelContext
    
    var pageState: Int
    var isFirst: Bool
    
    @Query private var patrimonios: [Patrimonio]
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    
    var body: some View {
            HStack{
                Image(isFirst ? "mapico1" :"mapico2")
                    .resizable()
                    .frame(width: 60, height: 30)
                
                Spacer()
                if isFirst{
                    OnboardingNavBarWhite(isActive: false, page: pageState)
                } else {
                    OnboardingNavBar(isActive: false, page: pageState)
                }
                
                Spacer()
                
                Button{
                    isOnboardingCompleted = true
                    router.setPath([.contentView])
                } label: {
                    Text("Saltar")
                        .foregroundStyle(isFirst ? .white : .gray)
                        .font(.custom(.raleway, style: .headline))
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
    }
}

struct HeaderAppView: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @EnvironmentObject var router: Router
    
    var headerTitle: String
    var body: some View {
        VStack{
            HStack{
                Image("mapico2")
                    .resizable()
                    .frame(width: 45, height: 23)
                    .onTapGesture {
                        isOnboardingCompleted = false
                        router.setPath([.contentView])
                    }
                Text(headerTitle)
                    .foregroundStyle(.rosaMex)
                    .font(.custom(.poppinsBold, style: .title2))
                
                Spacer()
                
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 36, height: 36)
                    .background(.gray.opacity(0.1))
                    .clipShape(Circle())
                    .fontWeight(.bold)
            }
            .padding(.vertical, 4)
            Divider()
                .background(Color.gray.opacity(0.5))
                .padding(.horizontal, -16)
        }
        .padding(.top, 8)
        
    }
}

struct HeaderAppViewExplore: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @EnvironmentObject var router: Router
    @Binding var isPresentingmap: Bool
    
    var headerTitle: String
    var body: some View {
        VStack{
            HStack{
                Image("mapico2")
                    .resizable()
                    .frame(width: 45, height: 23)
                    .onTapGesture {
                        isOnboardingCompleted = false
                        router.setPath([.contentView])
                    }
                Text(headerTitle)
                    .foregroundStyle(.rosaMex)
                    .font(.custom(.poppinsBold, style: .title2))
                
                Spacer()
                
                Button{
                    isPresentingmap.toggle()
                } label: {
                    Circle()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.gray.opacity(0.1))
                        .overlay{
                            Image(systemName: isPresentingmap ? "list.bullet" : "map.fill")
                                .font(.headline)
                                .foregroundStyle(.black)
                        }
                }
            }
            .padding(.vertical, 4)
            Divider()
                .background(Color.gray.opacity(0.5))
                .padding(.horizontal, -16)
                .padding(.bottom,0)
        }
        .padding(.top, 8)
    }
}

struct HeaderAppViewComponent: View {
    @EnvironmentObject var router: Router
    var body: some View {
        VStack{
            HStack{
                Button{
                    router.navigateToRoot()
                } label: {
                    Circle()
                        .frame(width: 36)
                        .foregroundStyle(.white)
                        .overlay{
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.black)
                                .frame(width: 10, height: 20)
                                .fontWeight(.bold)
                                .offset(x: -1)
                        }
                }
                
                Spacer()
                Circle()
                    .frame(width: 36)
                    .foregroundStyle(.white)
                    .overlay{
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12)
                            .fontWeight(.bold)
                    }
            }
        }
    }
}

struct OnboardingNavBar: View {
    @State var isActive: Bool
    @State var page: Int
    
    var body: some View {
        HStack(spacing: 15){
            ForEach(0..<4){ i in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(i == page ? Color(.rosaMex) : Color(.gray.opacity(0.6)))
            }
            .offset(x: -8)
        }
        .padding(.horizontal)
        .offset(x: 2)
    }
}

struct OnboardingNavBarWhite: View {
    @State var isActive: Bool
    @State var page: Int
    
    var body: some View {
        HStack(spacing: 15){
            ForEach(0..<4){ i in
                if i == page {
                    Circle()
                        .frame(width: 14)
                        .foregroundStyle(.white)
                        .overlay{
                            Circle()
                                .frame(width: 10)
                                .foregroundStyle(.rosaMex)
                        }
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)
                }
            }
            .offset(x: -8)
        }
        .padding(.horizontal)
        .offset(x: 2)
    }
}

#Preview {
    //HeaderAppView(headerTitle: "Herencia Viva")
    //HeaderAppViewComponent()
    HeaderAppView(headerTitle: "Herencia Viva")
    HeaderAppViewExplore(isPresentingmap: .constant(true), headerTitle: "Explora")
    HeaderAppViewComponent()
    HeaderAppViewOnboarding(pageState: 0, isFirst: true)
}
