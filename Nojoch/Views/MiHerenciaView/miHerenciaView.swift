//
//  miHerenciaView.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 25/09/24.
//

import SwiftUI
import SwiftData

struct miHerenciaView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var patrimonios: [Patrimonio]
    @Query private var estados: [Estado]
    
    @State var selectedDonutName: String = "Patrimonios visitados"
    @State var selectedDonutValue: String = ""
    @State private var categories: [Category] = []
    @State private var filteredPatrimonios: [Patrimonio] = []
    @State private var displayedPatrimonios: [Patrimonio] = []
    
    @State private var visitedEstados: [(estado: Estado, visitedCount: Int)] = []
    @State private var nonVisitedEstados: [(estado: Estado, visitedCount: Int)] = []
    
    var body: some View {
        VStack {
            HeaderAppView(headerTitle: "Mi herencia")
                .padding(.horizontal, 20)
            
            ScrollView {
                donutChartPatrimonios(categories: categories, filteredPatrimonios: filteredPatrimonios, selectedDonutValue: $selectedDonutValue, selectedDonutName: $selectedDonutName)
                
                visitedPatrimonios(displayedPatrimonios: displayedPatrimonios, selectedName: selectedDonutName)
                
                estadosMiHerencia(visitedEstados: visitedEstados, nonVisitedEstados: nonVisitedEstados)
            }
            
            Spacer()
        }
        .onAppear {
            if categories.isEmpty {
                fetchData()
            }
            sortEstadosByVisitStatus()
        }
        .onChange(of: selectedDonutName) {
            if selectedDonutName == "Patrimonios visitados" {
                displayedPatrimonios = filteredPatrimonios
            } else {
                displayedPatrimonios = filteredPatrimonios.filter { $0.tags.contains(selectedDonutName) }
            }
        }
    }
    
    func fetchData() {
        var tagCount: [String: Int] = [:]
        var estadoCount: [String: Bool] = [:]
        filteredPatrimonios = patrimonios.filter { $0.visited }
        displayedPatrimonios = filteredPatrimonios
        
        for patrimonio in filteredPatrimonios {
            estadoCount[patrimonio.estado, default: false] = true
            for tag in patrimonio.tags {
                tagCount[tag, default: 0] += 1
            }
        }
        
        selectedDonutValue = "\(filteredPatrimonios.count)"
        
        for tag in tagCount {
            let color = Color.tagColors[tag.key] ?? .rosaMex
            categories.append(Category(color: color, chartValue: CGFloat(tag.value), name: tag.key))
        }
    }
    
    func sortEstadosByVisitStatus() {
        let visitedPatrimoniosByEstado = Dictionary(grouping: patrimonios.filter { $0.visited }) { $0.estado }
        
        visitedEstados = estados
            .filter { visitedPatrimoniosByEstado.keys.contains($0.nombre) }
            .map { estado in
                let visitedCount = visitedPatrimoniosByEstado[estado.nombre]?.count ?? 0
                return (estado: estado, visitedCount: visitedCount)
            }
        
        nonVisitedEstados = estados
            .filter { !visitedPatrimoniosByEstado.keys.contains($0.nombre) }
            .map { estado in
                return (estado: estado, visitedCount: 0)
            }
    }
}

struct donutChartPatrimonios: View {
    var categories: [Category]
    var filteredPatrimonios: [Patrimonio]
    
    @Binding var selectedDonutValue: String
    @Binding var selectedDonutName: String
    var body: some View {
        ZStack {
            DonutChart(dataModel: ChartDataModel.init(dataModel: categories), onTap: {
                dataModel in
                if let dataModel = dataModel {
                    selectedDonutValue = "\(Int(dataModel.chartValue))"
                    selectedDonutName = "\(dataModel.name)"
                } else {
                    selectedDonutValue = "\(filteredPatrimonios.count)"
                    selectedDonutName = "Patrimonios visitados"
                }
            })
            .frame(width: 250, height: 250, alignment: .center)
            .padding()
            
            VStack{
                Text(selectedDonutValue)
                    .multilineTextAlignment(.center)
                    .font(.custom(.poppinsSemiBold, style: .title))
                Text(selectedDonutName)
                    .font(.custom(.poppinsSemiBold, style: .title3))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .frame(width: 150)
            }
        }
        .frame(width: 250, height: 250, alignment: .center)
        .padding()
    }
}

struct visitedPatrimonios:View {
    var displayedPatrimonios: [Patrimonio]
    var selectedName: String
    
    var body: some View {
        HStack{
            Text("Patrimonios")
                .fontWeight(.semibold)
                .foregroundStyle(.rosaMex) +
            Text(selectedName != "Patrimonios visitados" ? " visitados con tag: " : " visitados")
                .fontWeight(.semibold) +
            Text(selectedName != "Patrimonios visitados" ? selectedName : "")
                .fontWeight(.semibold)
                .foregroundColor(selectedName != "Patrimonios visitados" ? Color.tagColors[selectedName] : .rosaMex)
            Spacer()
        }
        .font(.custom(.poppinsSemiBold, style: .body))
        .padding(.leading,20)
        
        ScrollView(.horizontal){
            HStack{
                ForEach(displayedPatrimonios, id: \.self){ patrimonio in
                    patrimonioEstadoCard(patrimonio: patrimonio)
                }
            }
            .padding(.bottom, 5)
        }
        .padding(.leading, 20)
        .padding(.bottom)
        .scrollIndicators(.hidden)
    }
}

struct estadosMiHerencia:View {
    let gridColumns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var visitedEstados: [(estado: Estado, visitedCount: Int)]
    var nonVisitedEstados: [(estado: Estado, visitedCount: Int)]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Estados Visitados")
                .font(.custom(.poppinsSemiBold, style: .headline))
            
            LazyVGrid(columns: gridColumns) {
                ForEach(visitedEstados, id: \.estado.id) { (estado, visitedCount) in
                    estadoRow(estado: estado, visitedCount: visitedCount, isVisited: true)
                }
            }
            
            Text("Estados por visitar")
                .font(.custom(.poppinsSemiBold, style: .headline))
                .padding(.top)
            
            LazyVGrid(columns: gridColumns) {
                ForEach(nonVisitedEstados, id: \.estado.id) { (estado, visitedCount) in
                    estadoRow(estado: estado, visitedCount: visitedCount, isVisited: false)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct estadoRow:View {
    @EnvironmentObject var router: Router
    
    var estado: Estado
    var visitedCount: Int
    var isVisited: Bool
    
    var body: some View {
        VStack {
            Image(estado.icono)
                .resizable()
                .scaledToFit()
                .grayscale(isVisited ? 0 : 1)
            Text(estado.nombre)
                .font(.custom(.poppinsSemiBold, style: .caption))
                .fontWeight(.semibold)
            Text("\(visitedCount) visitados")
                .foregroundStyle(.gray)
                .font(.custom(.poppinsSemiBold, style: .custom10))
        }
        .onTapGesture {
            router.navigate(to: .estadoView(estado: estado))
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
    }
}

#Preview {
    miHerenciaView()
}
