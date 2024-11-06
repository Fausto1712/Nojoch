//
//  CustomARViewRepresentable.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 29/10/24.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    var viewModel: ARViewModel
    
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView(viewModel: viewModel)
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}
