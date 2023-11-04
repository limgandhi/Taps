//
//  ThemeObject.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/06.
//

import SwiftUI

class ThemeObject: ObservableObject {
    @Published var currentTheme: Theme
    
    init(currentTheme: Theme = .day) {
        self.currentTheme = currentTheme
    }
}
