//
//  VibrationSetUtil.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/30.
//

import SwiftUI
import CoreHaptics

class VibrationUtil{
    @AppStorage("vibration") var vibration: Vibration = .on
    static let instance = VibrationUtil()
    private var engine: CHHapticEngine?
    
    init() {
        self.prepareHaptics()
    }
    
    func prepareHaptics(){
        //해당 기기가 CoreHaptic 지원하는지 확인
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        }catch{
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    //vibrantion on
    func setOnVibration(){
        if self.vibration == .off {return}
        
        DispatchQueue.global().async {
            var events = [CHHapticEvent]()
            // Create an intensity parameter:
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
            let long = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity,sharpness], relativeTime: 0,duration: 0.5)
            events.append(long)
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try self.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch let error {
                print("Pattern Player Creation Error: \(error)")
            }
        }
    }
    
    //moving gauge hand
    func moveHandVibration(){
        if self.vibration == .off {return}
        DispatchQueue.global().async {
            var events = [CHHapticEvent]()
            // Create an intensity parameter:
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 0)
            
            events.append(event)
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try self.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch let error {
                print("Pattern Player Creation Error: \(error)")
            }
        }
    }
    
    //tapped score object
    func tapScoreObjectVibration(){
        if self.vibration == .off {return}
        DispatchQueue.global().async {
            var events = [CHHapticEvent]()
            // Create an intensity parameter:
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 0)
            
            events.append(event)
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try self.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch let error {
                print("Pattern Player Creation Error: \(error)")
            }
        }
    }
    
    //tapped penalty object
    func tapPenaltyObjectVibration(){
        if self.vibration == .off {return}
        DispatchQueue.global().async {
            var events = [CHHapticEvent]()
            // Create an intensity parameter:
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
            let long = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity,sharpness], relativeTime: 0,duration: 0.5)
            events.append(long)
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try self.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch let error {
                print("Pattern Player Creation Error: \(error)")
            }
        }
    }
    
    //close to out of time
    func outOfTimeVibration(){
        if self.vibration == .off {return}
        DispatchQueue.global().async {
            var events = [CHHapticEvent]()
            // Create an intensity parameter:
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.45)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
            let long = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity,sharpness], relativeTime: 0, duration: 0.07)
            events.append(long)
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try self.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch let error {
                print("Pattern Player Creation Error: \(error)")
            }
        }
    }
    
    //confetti vibration
    func confettiVibration(){
        if self.vibration == .off {return}
        DispatchQueue.global().async {
            var events = [CHHapticEvent]()
            
            for i in stride(from: 0, to: 0.25, by: 0.05){
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value:Float.random(in: 0.3 ... 0.7))
                let sharpness = CHHapticEventParameter(parameterID: .hapticIntensity, value:Float.random(in: 0.5 ... 1.0))
                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: i)
                events.append(event)
            }
            
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try self.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch let error {
                print("Pattern Player Creation Error: \(error)")
            }
        }
    }
}
