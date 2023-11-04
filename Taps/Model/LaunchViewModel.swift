//
//  LaunchViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/05.
//


import SwiftUI
import Combine

class LaunchViewModel: ObservableObject {
    @Published var sentences: [String]?
    @Published var count: Int
    @Published var showLaunchView = true
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common)
    private var cancellable = Set<AnyCancellable>()
    
    init(sentences:[String] = ["Tap","Speeedy~!"].reversed()) {
        self.sentences = sentences
        self.count = sentences.count
    }
    
    func startTimer() {
        timer
            .autoconnect()
            .sink {[weak self] _ in
                guard let self = self else {return}
                if self.count > 0{
                    self.count -= 1
                }else{
                    withAnimation {
                        self.showLaunchView = false
                    }
                    self.stopTimer()
                }
            }
            .store(in: &cancellable)
    }
    
    func stopTimer(){
        for c in cancellable {
            c.cancel()
        }
    }
}
