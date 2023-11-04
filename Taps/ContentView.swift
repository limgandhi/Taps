//
//  ContentView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject var launchViewModel = LaunchViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    
    @AppStorage("theme") var theme: Theme = .day
    @StateObject var themeObject = ThemeObject()
    @StateObject var settingObject = SettingObject()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            themeObject.currentTheme.colorSet.background
                .ignoresSafeArea()
            HomeView(homeViewModel: homeViewModel)
                .environmentObject(themeObject)
                .environmentObject(settingObject)
            LaunchView(launchViewModel: launchViewModel)
                .environmentObject(themeObject)
                .onDisappear{
                    withAnimation {
                        homeViewModel.showHomeView = true
                    }
                }
        }
        .onAppear{
            themeObject.currentTheme = theme
        }
        .onChange(of: themeObject.currentTheme) { newValue in
            self.theme = newValue
        }
        .onChange(of: settingObject.soundIsChecked, perform: { newValue in
            SoundUtil.instance.sound = newValue ? .on : .off
            SoundUtil.instance.setOnSound()
        })
        .onChange(of: settingObject.vibrationIsChecked, perform: { newValue in
            VibrationUtil.instance.vibration = newValue ? .on : .off
            VibrationUtil.instance.setOnVibration()
        })
        .onChange(of: scenePhase) { newValue in
            switch newValue{
            case .active:
//                vibrationObject.prepareHaptics()
//                SoundUtil.instance.prepareSoundPlayer()
                VibrationUtil.instance.prepareHaptics()
            default:
                print("test")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
