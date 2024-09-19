//
//  Item.swift
//  Nojoch
//
//  Created by Fausto Pinto Cabrera on 19/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
