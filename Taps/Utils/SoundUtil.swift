//
//  SoundSetUtil.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/30.
//

import SwiftUI
import AVKit

class SoundUtil{
    @AppStorage("sound") var sound: Sound = .on
    static let instance = SoundUtil()
    
    var gaugeSoundPlayer: AVAudioPlayer?
    var soundOnSoundPlayer: AVAudioPlayer?
    var scoreSoundPlayer: AVAudioPlayer?
    var penaltySoundPlayer: AVAudioPlayer?
    var confettiSoundPlayer: AVAudioPlayer?
    var outOfTimeSoundPlayer: AVAudioPlayer?

    init(){
        if sound == .on{
            self.prepareSoundPlayer()
        }
    }

    func prepareSoundPlayer(){
//        do{
//            gaugeSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.gauge)
//            soundOnSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.soundOn)
//            scoreSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.score)
//            penaltySoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.penalty)
//            confettiSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.confetti)
//            outOfTimeSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.outOtTime)
//        }catch let error {
//            print(error.localizedDescription)
//        }
        
        //prevent firsttime delay
        DispatchQueue.global().async {
            do{
                try AVAudioSession.sharedInstance().setCategory(
                    AVAudioSession.Category.playback
                )
                
                try AVAudioSession.sharedInstance().setActive(true)
                self.soundOnSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.soundOn)
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.soundOnSoundPlayer?.prepareToPlay()
        }
        
    }
    
    //sound on
    func setOnSound(){
        if self.sound == .off {return}
        DispatchQueue.global().async {
            do{
                try AVAudioSession.sharedInstance().setCategory(
                    AVAudioSession.Category.playback
                )
                
                try AVAudioSession.sharedInstance().setActive(true)
                self.soundOnSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.soundOn)
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.soundOnSoundPlayer?.play()
        }
    }
    
    //moving gauge hand
    func moveHandSound(){
        if self.sound == .off {return}
        DispatchQueue.global().async {
            do{
                self.gaugeSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.gauge)
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.gaugeSoundPlayer?.play()
        }
    }
    
    
    //tapped score object
    func tapScoreObjectSound(){
        if self.sound == .off {return}
        DispatchQueue.global().async {
            do{
                self.scoreSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.score)
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.scoreSoundPlayer?.play()
        }
    }
    
    //tapped penalty object
    func tapPenaltyObjectSound(){
        if self.sound == .off {return}
        DispatchQueue.global().async {
            do{
                self.penaltySoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.penalty)
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.penaltySoundPlayer?.play()
        }
    }
    
    //close to out of time
    func outOfTimeSound(){
        if self.sound == .off {return}
        DispatchQueue.global().async {
            do{
                self.outOfTimeSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.outOtTime)
            }catch let error{
                print(error.localizedDescription)
            }
            
            self.outOfTimeSoundPlayer?.play()
        }
    }
    
    //confetti
    func confettiSound(){
        if self.sound == .off {return}
        DispatchQueue.global().async {
            do{
                self.confettiSoundPlayer = try AVAudioPlayer(contentsOf: SoundUrl.confetti)
                
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.confettiSoundPlayer?.play()
        }
    }
}

struct SoundUrl{
    static let gauge =  Bundle.main.url(forResource: "wrench", withExtension: ".mp3")!
    static let soundOn =  Bundle.main.url(forResource: "bicycle-bell", withExtension: ".mp3")!
    static let score =  Bundle.main.url(forResource: "correct2", withExtension: ".mp3")!
    static let penalty =  Bundle.main.url(forResource: "window-error", withExtension: ".mp3")!
    static let confetti =  Bundle.main.url(forResource: "confetti", withExtension: ".mp3")!
    static let outOtTime =  Bundle.main.url(forResource: "rightanswer", withExtension: ".mp3")!
}
