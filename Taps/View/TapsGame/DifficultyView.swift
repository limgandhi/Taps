//
//  DifficultyView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/20.
//

import SwiftUI

struct DifficultyView: View {
    @StateObject var difficultyViewModel: DifficultyViewModel
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var body: some View {
        HStack{
            Image("left")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .opacity(difficultyViewModel.hideLeftArrow ? 0 : 1)
                .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                .onTapGesture {
                    difficultyViewModel.decreaseDifficulty()
                    SoundUtil.instance.moveHandSound()
                    VibrationUtil.instance.moveHandVibration()
                }
            ZStack{
                Image(themeObject.currentTheme == .day ?
                      "gauge_day" : "gauge_night")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 400)
                    .overlay {
                        Image(themeObject.currentTheme == .day ?
                              "hand_day" : "hand_night")
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: difficultyViewModel.currentDifficulty.handAngle),anchor: .init(x: 0.5, y: 0.9))
                    }
            }
            Image("right")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .opacity(difficultyViewModel.hideRightArrow ? 0 : 1)
                .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                .onTapGesture {
                    difficultyViewModel.increaseDifficulty()
                    SoundUtil.instance.moveHandSound()
                    VibrationUtil.instance.moveHandVibration()
                }
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView(difficultyViewModel: DifficultyViewModel())
            .environmentObject(ThemeObject(currentTheme: .day))
    }
}
