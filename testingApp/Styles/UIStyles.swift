//
//  UIStyles.swift
//  testingApp
//
//  Created by Magdiel G. on 09/06/23.
//

import Foundation
import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension TextField {

    func extensionTextFieldView(roundedCornes: CGFloat, startColor: Color,  endColor: Color) -> some View {
        self
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .shadow(color: .gray, radius: 10)
    }
}
