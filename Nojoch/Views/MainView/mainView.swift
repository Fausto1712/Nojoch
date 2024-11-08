//
//  mainView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

struct TagTranslations {
    let original: String
    let nahualt: String
    let maya: String
}

import SwiftUI
import SwiftData

struct mainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var patrimonios: [Patrimonio]
    @Query private var estados: [Estado]
    @Query private var comunidades: [Comunidad]
    
    var body: some View {
        VStack(alignment: .leading){
            
            HeaderAppView(headerTitle: "Herencia Viva")
                .padding(.horizontal, 32)
            
            ScrollView{
                HStack{
                    Text("Patrimonios")
                        .foregroundStyle(.rosaMex) +
                    Text(" de hoy")
                    Spacer()
                }
                .font(.custom(.poppinsSemiBold, style: .headline))
                .padding(.top, 14)
                .padding(.bottom, 10)
                .padding([.horizontal])
                
                Rectangle()
                    .foregroundStyle(.quinary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .padding(.vertical, 12)
                
                
                
                ForEach(patrimonios, id: \.id) { patrimonio in
                    patrimonioCard(patrimonio: patrimonio)
                    //.padding(.horizontal)
                    
                    Rectangle()
                        .foregroundStyle(.quinary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 4)
                        .padding(.vertical, 12)
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .horizontal)
            .padding(.top, -8)
        }
        .padding(.horizontal, -16)
    }
}

struct patrimonioCard: View {
    @EnvironmentObject var router: Router
    
    @StateObject private var transNahualtModel = TranslationNahualtModel()
    @StateObject private var transMayaModel = TranslationMayaModel()
    @State private var tagTranslations: [TagTranslations] = []
    @State private var selectedLanguage: String = "Español"
    
    var patrimonio: Patrimonio
    
    var body: some View {
        VStack {
            HStack {
                HStack{
                    Image(patrimonio.personaFoto)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(patrimonio.persona)
                            .font(.custom(.raleway, style: .subheadline))
                            .fontWeight(.semibold)
                        
                        HStack {
                            Text("\(patrimonio.comunidad), ")
                                .font(.custom(.raleway, style: .footnote))
                                .fontWeight(.semibold)
                                .foregroundStyle(.rosaMex) +
                            Text(patrimonio.estado)
                                .font(.custom(.raleway, style: .footnote))
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.leading, 4)
                }
                .onTapGesture {
                    router.navigate(to: .patrimonio(patrimonio: patrimonio))
                }
                
                Spacer()
                
                Menu {
                    Button("Náhualt") { withAnimation{ selectedLanguage = "Nahualt" }}
                    Button("Maya") { withAnimation{ selectedLanguage = "Maya" }}
                    Button("Español") { withAnimation{ selectedLanguage = "Español" }}
                } label: {
                    Image(systemName: "globe")
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .offset(y: -2)
                }
            }
            .padding(.horizontal)
            VStack{
                if patrimonio.descripcion != "" {
                    Text(patrimonio.descripcion)
                        .font(.custom(.raleway, style: .custom14))
                        .fontWeight(.medium)
                        .padding(.top, 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                TabView {
                    ForEach(patrimonio.fotos, id: \.self) { foto in
                        Image(foto)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(height: 265)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .tabViewStyle(PageTabViewStyle())
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: 16)

                    HStack(spacing: 8) {
                        ForEach(tagTranslations, id: \.original) { tagTranslation in
                            HStack(spacing: 8) {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(.white)
                                Text(getTag(for: tagTranslation))
                                    .foregroundStyle(.white)
                                    .font(.custom(.raleway, style: .footnote))
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.tagColors[tagTranslation.original] ?? .rosaMex)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }

                    Spacer()
                        .frame(width: 16)
                }
            }
            .padding(.vertical, 4)

            
            HStack {
                Text(patrimonio.fecha.toSpanishFormattedString())
                    .font(.custom(.raleway, style: .caption))
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.top, 4)
            .padding(.horizontal)
        }
        .onTapGesture {
            router.navigate(to: .patrimonio(patrimonio: patrimonio))
        }
        .onAppear {
            setupTagTranslations()
        }
    }
    
    func getTag(for tagTranslation: TagTranslations) -> String {
        switch selectedLanguage {
        case "Nahualt":
            return tagTranslation.nahualt
        case "Maya":
            return tagTranslation.maya
        default:
            return tagTranslation.original
        }
    }
    
    func setupTagTranslations() {
        tagTranslations = patrimonio.tags.map { tag in
            TagTranslations(
                original: tag,
                nahualt: transNahualtModel.translate(tag.lowercased()).capitalized,
                maya: transMayaModel.translate(tag).capitalized
            )
        }
    }
}

#Preview {
    mainView()
}
