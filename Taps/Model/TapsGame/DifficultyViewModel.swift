//
//  DifficultyViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/25.
//

import SwiftUI
import Combine

class DifficultyViewModel: ObservableObject {
    @AppStorage("difficulty") var difficulty: Difficulty = .medium
    
    @Published var currentDifficulty: Difficulty = .medium
    
    @Published var hideLeftArrow = false
    @Published var hideRightArrow = false
    
    var cancellable = Set<AnyCancellable>()
    
    init(){
        self.currentDifficulty = self.difficulty
        synchronizeCurrentDifficultyWithAppStorage()
        hideArrow()
    }
    
    func synchronizeCurrentDifficultyWithAppStorage(){
        $currentDifficulty.sink { newValue in
            self.difficulty = newValue
        }
        .store(in: &cancellable)
    }
    
    func increaseDifficulty(){
        switch (self.currentDifficulty){
        case .superEasy:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .easy
            }
            break
        case .easy:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .medium
            }
            break
        case .medium:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .hard
            }
            break
        case .hard:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .superHard
            }
            break
        case .superHard:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .superHard
            }
            break
        }
        hideArrow()
    }
    
    func decreaseDifficulty(){
        switch (self.currentDifficulty){
        case .superEasy:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .superEasy
            }
            break
        case .easy:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .superEasy
            }
            break
        case .medium:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .easy
            }
            break
        case .hard:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .medium
            }
            break
        case .superHard:
            withAnimation(.interactiveSpring(dampingFraction: 0.35)) {
                self.currentDifficulty = .hard
            }
            break
        }
        hideArrow()
    }
    
    func hideArrow(){
        if self.currentDifficulty == .superEasy {
            self.hideLeftArrow = true
        }else if self.currentDifficulty == .superHard {
            self.hideRightArrow = true
        }else{
            self.hideLeftArrow = false
            self.hideRightArrow = false
        }
    }
    
}
