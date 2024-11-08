//
//  ARViewModel.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 04/11/24.
//

import Foundation

class ARViewModel: ObservableObject {
    @Published var text: String = ""
    func setSelection(_ selected: String) {
        text = selected
    }
}
