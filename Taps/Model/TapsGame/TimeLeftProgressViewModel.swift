//
//  TimeLeftProgressViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/11.
//

import SwiftUI
import Combine

protocol TimeLeftProgressViewDelegate {
    func setDifficulty(difficulty: Difficulty) -> Void
    func getTimeout() -> Published<Bool>.Publisher
    func addGameTime(time: Double) -> Void
    func subtractGameTime(time: Double) -> Void
    func startTimer() -> Void
    func pauseTimer() -> Void
    func stopTimer() -> Void
    func resetTimer() -> Void
}


class TimeLeftProgressViewModel: ObservableObject, TimeLeftProgressViewDelegate{
    @Published var timeLeft = 1.0
    @Published var offset: CGSize = .zero
    @Published var brightness = 0.0
    @Published var difficulty: Difficulty
    @Published var timeout = false
    var width: CGFloat
    var height: CGFloat
    
    var isProcessing = false
    
    var gameTimer: Timer.TimerPublisher {
        get{
            switch difficulty{
            case .superEasy:
                return Timer.publish(every: 0.3, on: .main, in: .common)
            case .easy:
                return Timer.publish(every: 0.05, on: .main, in: .common)
            case .medium:
                return Timer.publish(every: 0.04, on: .main, in: .common)
            case .hard:
                return Timer.publish(every: 0.037, on: .main, in: .common)
            case .superHard:
                return Timer.publish(every: 0.03, on: .main, in: .common)
            }
        }
    }
    let brightenTimer = Timer.publish(every: 0.15, on: .main, in: .common)
    var cancellable = Set<AnyCancellable>()
    
    init(width: CGFloat = 0.0, height: CGFloat = 0.0,difficulty: Difficulty = .superEasy){
        self.width = width
        self.height = height
        self.difficulty = difficulty
    }
    
    func addGameTime(time: Double){
        self.timeLeft = self.timeLeft + time > 1.0 ? 1.0 : self.timeLeft + time
    }
    
    func subtractGameTime(time: Double) {
        self.timeLeft = self.timeLeft - time < 0.0 ? 0.0 : self.timeLeft - time
    }
    
    func startGameTimer(){
        gameTimer
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                withAnimation(.spring()) {
                    if self.timeLeft > 0.0{
                        self.timeLeft -= 0.01
                        self.timeLeft = self.timeLeft < 0.0 ? 0.0 : self.timeLeft
                    }else{
                        self.timeout = true
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    func startBrightenTimer(){
        brightenTimer
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                withAnimation(.spring()) {
                    if self.timeLeft <= 0.4 && self.timeLeft > 0{
                        self.startBrightenProgressView()
                        SoundUtil.instance.outOfTimeSound()
                        VibrationUtil.instance.outOfTimeVibration()
                    }
                    else {
                        self.stopBrightenProgressView()
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    func startBrightenProgressView(){
        if self.brightness == 0.0 {
            self.brightness = 0.7
        }else {
            self.brightness *= -1
        }
    }
    
    func stopBrightenProgressView(){
        self.brightness = 0.0
    }
    
    func setDifficulty(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    func getTimeout() -> Published<Bool>.Publisher {
        return $timeout
    }
    
    func startTimer(){
        if !isProcessing {
            startGameTimer()
            startBrightenTimer()
            isProcessing = true
        }
    }
    
    func pauseTimer(){
        isProcessing = false
        for c in self.cancellable{
            c.cancel()
        }
    }
    
    func stopTimer(){
        isProcessing = false
        self.stopBrightenProgressView()
        for c in self.cancellable{
            c.cancel()
        }
    }
    
    func resetTimer(){
        self.timeLeft = 1.0
        self.timeout = false
    }
    
}
