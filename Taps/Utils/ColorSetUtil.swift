//
//  ColorSet.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/05.
//

import SwiftUI

//Two Background Theme and Five Circle Theme in each Background Theme

class ColorSetUtil{
    static let dayMode: ColorSetObject = ColorSetObject(background: ColorToken.background_day,
                                                        font: ColorToken.font_day,
                                                        stroke: ColorToken.stroke_day,
                                                        superEasyScoreTapButton: ColorToken.scoreTapButton_superEasy,
                                                        easyScoreTapButton: ColorToken.scoreTapButton_easy,
                                                        mediumScoreTapButton: ColorToken.scoreTapButton_medium,
                                                        hardScoreTapButton: ColorToken.scoreTapButton_hard,
                                                        superHardScoreTapButton: ColorToken.scoreTapButton_superHard,
                                                        penaltyTapButton: ColorToken.penaltyTapButton)
    
    static let nightMode: ColorSetObject = ColorSetObject(background: ColorToken.background_night,
                                                          font: ColorToken.font_night,
                                                          stroke: ColorToken.stroke_night,
                                                          superEasyScoreTapButton: ColorToken.scoreTapButton_superEasy,
                                                          easyScoreTapButton: ColorToken.scoreTapButton_easy,
                                                          mediumScoreTapButton: ColorToken.scoreTapButton_medium,
                                                          hardScoreTapButton: ColorToken.scoreTapButton_hard,
                                                          superHardScoreTapButton: ColorToken.scoreTapButton_superHard,
                                                          penaltyTapButton: ColorToken.penaltyTapButton)
}


struct ColorSetObject {
    let background: Color
    let font: Color
    let stroke: Color
    
    let superEasyScoreTapButton: Color
    let easyScoreTapButton: Color
    let mediumScoreTapButton: Color
    let hardScoreTapButton: Color
    let superHardScoreTapButton: Color
    
    let penaltyTapButton: Color
}

class RGBConversionUtil{
    //rgb(255, 251, 235) text
    static func toDouble(_ intNumber:Int) -> Double{
        return Double(intNumber) / 255.0
    }
}

struct ColorToken{
    static let background_day = Color(red: RGBConversionUtil.toDouble(240), green: RGBConversionUtil.toDouble(231), blue: RGBConversionUtil.toDouble(210))
    static let background_night = Color(red: RGBConversionUtil.toDouble(30), green: RGBConversionUtil.toDouble(30), blue: RGBConversionUtil.toDouble(30))
    
    static let font_day = Color(red: RGBConversionUtil.toDouble(30), green: RGBConversionUtil.toDouble(30), blue: RGBConversionUtil.toDouble(30))
    static let font_night = Color(red: RGBConversionUtil.toDouble(240), green: RGBConversionUtil.toDouble(231), blue: RGBConversionUtil.toDouble(210))
    
    static let stroke_day = Color(red: RGBConversionUtil.toDouble(30), green: RGBConversionUtil.toDouble(30), blue: RGBConversionUtil.toDouble(30))
    static let stroke_night = Color(red: RGBConversionUtil.toDouble(240), green: RGBConversionUtil.toDouble(231), blue: RGBConversionUtil.toDouble(210))
    
    static let scoreTapButton_superEasy = Color(red: RGBConversionUtil.toDouble(0), green: RGBConversionUtil.toDouble(161), blue: RGBConversionUtil.toDouble(231))
    static let scoreTapButton_easy = Color(red: RGBConversionUtil.toDouble(97), green: RGBConversionUtil.toDouble(188), blue: RGBConversionUtil.toDouble(69))
    static let scoreTapButton_medium = Color(red: RGBConversionUtil.toDouble(251), green: RGBConversionUtil.toDouble(185), blue: RGBConversionUtil.toDouble(37))
    static let scoreTapButton_hard = Color(red: RGBConversionUtil.toDouble(247), green: RGBConversionUtil.toDouble(130), blue: RGBConversionUtil.toDouble(34))
    static let scoreTapButton_superHard = Color(red: RGBConversionUtil.toDouble(217), green: RGBConversionUtil.toDouble(52), blue: RGBConversionUtil.toDouble(63))
    
    static let penaltyTapButton = Color(red: RGBConversionUtil.toDouble(119), green: RGBConversionUtil.toDouble(72), blue: RGBConversionUtil.toDouble(162))
}
