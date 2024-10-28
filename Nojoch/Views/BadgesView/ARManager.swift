//
//  ARManager.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 28/10/24.
//

import Combine
import Foundation

class ARManager {
    static let shared = ARManager()
    private init(){}
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
