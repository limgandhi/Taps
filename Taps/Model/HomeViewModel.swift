//
//  HomeViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/12.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var showHomeView: Bool
    @Published var showSettingView: Bool = false
    
    @Published var brightEffect: Bool = false
    
    let timer1 = Timer.publish(every: 1.2, on: .main, in: .common)
    let timer2 = Timer.publish(every: 1.2, on: .main, in: .common)
    
    var cancellable = Set<AnyCancellable>()
    
    init(showHomeView: Bool = false) {
        self.showHomeView = showHomeView
    }
    
    func startTimer1(){
        timer1
            .autoconnect()
            .sink { [weak self] _ in
            guard let self = self else {return}
                withAnimation(.spring()) {
                    self.brightEffect = false
                }
        }
        .store(in: &cancellable)
    }
    func startTimer2(){
        timer2
            .autoconnect()
            .sink {[weak self] _ in
            guard let self = self else {return}
                withAnimation(.spring()) {
                    self.brightEffect = true
                }
        }
        .store(in: &cancellable)
    }
    
    func startTimer() {
        startTimer2()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: startTimer1)
    }
    
    func stopTimer() {
        for c in cancellable{
            c.cancel()
        }
    }
}
