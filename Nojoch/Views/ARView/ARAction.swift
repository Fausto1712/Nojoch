//
//  ARAction.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 29/10/24.
//

import Foundation
import SwiftUI

enum ARAction {
    case showBadge(type: String)
    case removeAllAnchors
    case showAllBadges(type: [String : String])
}
