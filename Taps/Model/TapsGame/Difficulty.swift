//
//  TapsGameDifficulty.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/16.
//

import SwiftUI
//conform RawValue to use Difficulty Enum in AppStorage
enum Difficulty: String{
    case superEasy, easy, medium, hard, superHard
    var title: String {
        switch self{
        case .superEasy: return "Super Easy"
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        case .superHard: return "Super Hard"
        }
    }
    
    var color: Color {
        switch self{
        case .superEasy: return .blue
        case .easy: return .red
        case .medium: return .green
        case .hard: return .orange
        case .superHard: return .pink
        }
    }
    
    var handAngle:Double{
        switch self{
        case .superEasy: return -76
        case .easy: return -40
        case .medium: return 0
        case .hard: return 40
        case .superHard: return 77.5
        }
    }
}
