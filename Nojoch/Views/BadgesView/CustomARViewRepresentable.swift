//
//  CustomARViewRepresentable.swift
//  Nojoch
//
//  Created by Alejandra Coeto on 22/10/24.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}
