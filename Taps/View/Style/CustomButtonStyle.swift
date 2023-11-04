//
//  CustomButtonStyle.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/10/04.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
