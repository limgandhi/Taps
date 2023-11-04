//
//  SettingObject.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/10/03.
//

import SwiftUI

class SettingObject: ObservableObject {
    @Published var soundIsChecked: Bool = true
    @Published var vibrationIsChecked: Bool = true
    init(){
        self.checkSoundIsChecked()
        self.checkVibrationIsChecked()
    }
    
    func checkSoundIsChecked(){
        soundIsChecked = SoundUtil.instance.sound == .on
    }
    
    func checkVibrationIsChecked(){
        vibrationIsChecked = VibrationUtil.instance.vibration == .on
    }
}
