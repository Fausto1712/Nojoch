//
//  DonutChartModel.swift
//
//  Created by Fausto Pinto Cabrera on 12/12/23.
//

import SwiftUI

final class ChartDataModel: ObservableObject {
    var category: [Category]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
    
        
    init(dataModel: [Category]) {
        category = dataModel
    }
    
    var totalValue: CGFloat {
        category.reduce(CGFloat(0)) { (result, data) -> CGFloat in
            result + data.chartValue
        }
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        return lastBarEndAngle
    }
}
