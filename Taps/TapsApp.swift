//
//  TapsApp.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/05.
//

import SwiftUI

@main
struct TapsApp: App {
    @AppStorage("difficulty") var difficulty: Difficulty = .medium
    @AppStorage("superEasyBestRecord") var superEasyBestRecord = 0
    @AppStorage("easyBestRecord") var easyBestRecord = 0
    @AppStorage("mediumBestRecord") var mediumBestRecord = 0
    @AppStorage("hardBestRecord") var hardBestRecord = 0
    @AppStorage("superHardBestRecord") var superHardBestRecord = 0
    @AppStorage("theme") var theme: Theme = .day
    @AppStorage("sound") var sound: Sound = .on
    @AppStorage("vibration") var vibration: Vibration = .on
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
