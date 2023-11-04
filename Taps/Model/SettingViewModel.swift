//
//  SettingViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/20.
//

import SwiftUI

class SettingViewModel: SettingObject {
    @Published var showSettingView: Bool
    
    init(showSettingView: Bool = false) {
        self.showSettingView = showSettingView
        super.init()
    }
}
