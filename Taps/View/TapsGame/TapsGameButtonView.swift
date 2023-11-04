//
//  TapsGameButtonView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/10.
//

import SwiftUI

struct TapsGameButtonView: View {
    @StateObject var tapsGame: TapsGameViewModel
    @StateObject var tapsGameObject: TapsObject
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var penaltyId: Int?
    
    var body: some View {
        Circle()
            .foregroundColor(getTapButtonColor())
            .overlay {
                if tapsGameObject.overlayX {
                    Image("xmark")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                }
            }
            .frame(maxWidth: CGFloat(tapsGameObject.frameWidth),maxHeight: CGFloat(tapsGameObject.frameHeight))
            .scaleEffect(tapsGameObject.scale)
            .blur(radius: tapsGameObject.blur)
            .opacity(tapsGameObject.opacity)
            .offset(tapsGameObject.offset)
            .onTapGesture {
                if !(tapsGameObject.disable || tapsGame.isPaused || tapsGame.isTerminated) {
                    if let penaltyId = penaltyId {
                        tapsGame.tapPenaltyView(id: tapsGameObject.id, penaltyId: penaltyId)
                        VibrationUtil.instance.tapPenaltyObjectVibration()
                        SoundUtil.instance.tapPenaltyObjectSound()
                    }else{
                        tapsGame.tapScoreView(id: tapsGameObject.id)
                        VibrationUtil.instance.tapScoreObjectVibration()
                        SoundUtil.instance.tapScoreObjectSound()
                    }
                }
            }
//            .disabled(tapsGameObject.disable || tapsGame.isPaused || tapsGame.isTerminated)
    }
    
    func getTapButtonColor()->Color{
        if penaltyId != nil {
            return themeObject.currentTheme.colorSet.penaltyTapButton
        }
        switch tapsGame.difficulty{
        case .superEasy:
            return themeObject.currentTheme.colorSet.superEasyScoreTapButton
        case .easy:
            return themeObject.currentTheme.colorSet.easyScoreTapButton
        case .medium:
            return themeObject.currentTheme.colorSet.mediumScoreTapButton
        case .hard:
            return themeObject.currentTheme.colorSet.hardScoreTapButton
        case .superHard:
            return themeObject.currentTheme.colorSet.superHardScoreTapButton
        }
    }
}

struct TapsGameButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TapsGameButtonView(tapsGame: TapsGameViewModel(),tapsGameObject: TapsObject())
            .environmentObject(ThemeObject())
    }
}
