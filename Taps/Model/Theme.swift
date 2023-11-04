//
//  Theme.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/05.
//

import SwiftUI

enum Theme: String{
    case day, night
    
    var colorSet: ColorSetObject{
        switch self {
        case .day:
            return ColorSetUtil.dayMode
        case .night:
            return ColorSetUtil.nightMode
        }
    }
}
