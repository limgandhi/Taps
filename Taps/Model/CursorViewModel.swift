//
//  CursorViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/10.
//

import SwiftUI
import Combine

class CursorViewModel: ObservableObject{
    @Published var offset: CGSize = .zero
    @Published var showCursorView: Bool = false
    @Published var effect: Bool = false
    
    let timer1 = Timer.publish(every: 1.2, on: .main, in: .common)
    let timer2 = Timer.publish(every: 1.2, on: .main, in: .common)
    
    var cancellable = Set<AnyCancellable>()
    
    func startTimer1(){
        timer1
            .autoconnect()
            .sink { [weak self] _ in
            guard let self = self else {return}
                withAnimation(.spring()) {
                    self.effect = false
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
                    self.effect = true
                }
        }
        .store(in: &cancellable)
    }
    
    func startTimer() {
        withAnimation {
            self.showCursorView = true
        }
        startTimer2()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: startTimer1)
    }
    
    func stopTimer() {
        withAnimation {
            self.showCursorView = false
        }
        for c in cancellable{
            c.cancel()
        }
    }
}
