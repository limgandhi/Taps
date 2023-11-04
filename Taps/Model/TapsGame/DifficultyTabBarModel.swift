//
//  DifficultyTabBarModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/24.
//

import SwiftUI

class DifficultyTabBarModel: ObservableObject{
    @AppStorage("difficulty") var difficulty: Difficulty = .medium
    
    @Published var tabSelection: Difficulty = .medium
    @Published var showTabBarView = true
    
    init(){
        self.tabSelection = self.difficulty
    }
}
