//
//  TapsGameViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/10.
//

import SwiftUI
import Combine

class TapsGameViewModel: ObservableObject{
    @AppStorage("superEasyBestRecord") var superEasyBestRecord = 0
    @AppStorage("easyBestRecord") var easyBestRecord = 0
    @AppStorage("mediumBestRecord") var mediumBestRecord = 0
    @AppStorage("hardBestRecord") var hardBestRecord = 0
    @AppStorage("superHardBestRecord") var superHardBestRecord = 0
    
    @Published var currentCount = 0
    @Published var bestRecord = 0
    @Published var scoreObjects: [TapsObject] = []
    @Published var penaltyObjects1: [TapsObject] = []
    @Published var penaltyObjects2: [TapsObject] = []
    @Published var isStarted = false
    @Published var isPaused = false
    @Published var isTerminated = false
    @Published var showGameView = true
    
    var difficulty: Difficulty = .medium
    var timeLeftProgressViewDelegate: TimeLeftProgressViewDelegate?
    var targetCount = 10
    var confettiCounter = 0
    var bestRecordUpdated = false
    
    private var objectWidth: CGFloat = 100
    private var objectHeight: CGFloat = 100
    
    
    private var objectOffsets:[(scoreOffset:CGSize, penalty1Offset:CGSize, penalty2Offset: CGSize)] = []
    private let penaltyOffsetTimer = Timer.publish(every: 0.05, on: .main, in: .common)
    private var penaltyCancellable = Set<AnyCancellable>()
    private var geometryValue: CGRect?
    private var cancellable = Set<AnyCancellable>()
    
    func initializeGame(){
        objectOffsets.removeAll()
        guard let width = geometryValue?.width, let height = geometryValue?.height else {return}
        objectWidth = (width / 4)
        objectHeight = objectWidth
        let offset = CGSize(width: width/2-objectWidth/2, height: height/2-objectHeight/2)
        scoreObjects.append(TapsObject(frameWidth: objectWidth, frameHeight: objectHeight, offset: offset))
        
        DispatchQueue.global(qos: .background).async{
            self.addObjectOffset()
        }
    }
    
    func increaseCurrentCount(){
        self.currentCount += 1
    }
    
    func addObjectOffset(){
        let score = getRandomGeometryValue()
        var penaltyObject1Offset: CGSize
        repeat{
            penaltyObject1Offset = getRandomGeometryValue()
        }while(!checkNotOverlapped(offsetA: score, offsetB: penaltyObject1Offset, frameWidth: objectWidth))
        let penalty1 = penaltyObject1Offset
        
        var penaltyObject2Offset: CGSize
        repeat{
            penaltyObject2Offset = getRandomGeometryValue()
        }while(!checkNotOverlapped(offsetA: score, offsetB: penaltyObject1Offset, offsetC: penaltyObject2Offset, frameWidth: objectWidth))
        let penalty2 = penaltyObject2Offset
        objectOffsets.append((score,penalty1,penalty2))
    }
    
    func addView(){
        DispatchQueue.global(qos: .background).async{
            let (scoreObjectOffset,penaltyObject1Offset,penaltyObject2Offset) = self.objectOffsets.removeFirst()
            self.addObjectOffset()
            
            if self.difficulty == .easy || self.difficulty == .medium{
                let penaltyObject1 = TapsObject(frameWidth: self.objectWidth, frameHeight: self.objectHeight, offset: penaltyObject1Offset)
                DispatchQueue.main.async {
                    self.scoreObjects.append(TapsObject(frameWidth: self.objectWidth, frameHeight: self.objectHeight, offset: scoreObjectOffset))
                    self.penaltyObjects1.append(penaltyObject1)
                }
            }else if self.difficulty == .hard || self.difficulty == .superHard{
                let penaltyObject1 = TapsObject(frameWidth: self.objectWidth, frameHeight: self.objectHeight, offset: penaltyObject1Offset)
                let penaltyObject2 = TapsObject(frameWidth: self.objectWidth, frameHeight: self.objectHeight, offset: penaltyObject2Offset)
                DispatchQueue.main.async {
                    self.scoreObjects.append(TapsObject(frameWidth: self.objectWidth, frameHeight: self.objectHeight, offset: scoreObjectOffset))
                    self.penaltyObjects1.append(penaltyObject1)
                    self.penaltyObjects2.append(penaltyObject2)
                }
            }else{
                DispatchQueue.main.async {
                    self.scoreObjects.append(TapsObject(frameWidth: self.objectWidth, frameHeight: self.objectHeight, offset: scoreObjectOffset))
                }
                
            }
        }
    }
    
    func getRandomGeometryValue()->CGSize{
        guard let width = geometryValue?.width, let height = geometryValue?.height else {return CGSize.zero}
        let timeLeftProgressViewHeight = 40
        let headerViewHeight = 120
        let randWidth = Int.random(in: 0...Int(width)-Int(objectWidth))
        let randHeight = Int.random(in: headerViewHeight...Int(height)-Int(objectHeight)-timeLeftProgressViewHeight)
        return CGSize(width: randWidth, height: randHeight)
    }
    
    func calculateDistnace(offsetA: CGSize, offsetB: CGSize)->Double{
        let widthDiff = offsetB.width - offsetA.width
        let heightDiff = offsetB.height - offsetA.height
        return sqrt(pow(widthDiff, 2)+pow(heightDiff, 2))
    }
    
    func checkNotOverlapped(offsetA: CGSize, offsetB: CGSize, frameWidth: CGFloat)->Bool{
        if calculateDistnace(offsetA: offsetA, offsetB: offsetB) > Double(frameWidth) {
            return true
        }else{
            return false
        }
    }
    
    func checkNotOverlapped(offsetA: CGSize, offsetB: CGSize, offsetC: CGSize, frameWidth: CGFloat)->Bool{
        if calculateDistnace(offsetA: offsetA, offsetB: offsetC) > Double(frameWidth) && calculateDistnace(offsetA: offsetB, offsetB: offsetC) > Double(frameWidth){
            return true
        }else{
            return false
        }
    }
    
    func removeScoreView(id:UUID){
        self.penaltyObjects1 = self.penaltyObjects1.map { object in
            object.disable = true
            return object
        }
        self.penaltyObjects2 = self.penaltyObjects2.map { object in
            object.disable = true
            return object
        }
        
        self.scoreObjects = self.scoreObjects.map { item in
            withAnimation {
                item.opacity = 0.0
                item.scale = 2.0
                item.blur = 20.0
                item.disable = true
            }
            return item
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.scoreObjects = self.scoreObjects.filter({ item in
                item.id != id
            })
        }
        
        self.objectWillChange.send()
    }
    
    func removePenaltyView(id:UUID, penaltyId: Int){
        //        shakePenaltyView(id: id, penaltyId: penaltyId)
        
        self.scoreObjects = self.scoreObjects.map { object in
            object.disable = true
            return object
        }
        
        if penaltyId == 1 {
            self.penaltyObjects2 = self.penaltyObjects2.map { object in
                object.disable = true
                return object
            }
            self.penaltyObjects1 = self.penaltyObjects1.map { item in
                if item.id == id {
                    withAnimation {
                        item.overlayX = true
                        item.disable = true
                    }
                }
                return item
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation {
                    self.penaltyObjects1 = self.penaltyObjects1.filter({ item in
                        item.id != id
                    })
                }
                //                for c in self.penaltyCancellable{
                //                    c.cancel()
                //                }
            }
        }else{
            self.penaltyObjects1 = self.penaltyObjects1.map { object in
                object.disable = true
                return object
            }
            self.penaltyObjects2 = self.penaltyObjects2.map { item in
                if item.id == id {
                    withAnimation {
                        item.overlayX = true
                        item.disable = true
                    }
                }
                return item
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.penaltyObjects2 = self.penaltyObjects2.filter({ item in
                    item.id != id
                })
                //                for c in self.penaltyCancellable{
                //                    c.cancel()
                //                }
            }
        }
        
        self.objectWillChange.send()
    }
    
    
    //not using for now
    func shakePenaltyView(id:UUID, penaltyId: Int){
        var offsetDiff = 10.0
        penaltyOffsetTimer
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                if penaltyId == 1 {
                    withAnimation(.spring(response: 0.05)) {
                        self.penaltyObjects1 = self.penaltyObjects1.map { item in
                            if item.id == id {
                                withAnimation {
                                    offsetDiff *= -1
                                    item.offset.width += offsetDiff
                                }
                            }
                            return item
                        }
                    }
                }else{
                    withAnimation(.spring(response: 0.05)) {
                        self.penaltyObjects2 = self.penaltyObjects2.map { item in
                            if item.id == id {
                                withAnimation {
                                    offsetDiff *= -1
                                    item.offset.width += offsetDiff
                                }
                            }
                            return item
                        }
                    }
                }
            }
            .store(in: &penaltyCancellable)
    }
    
    func setGeometryValue(geometryValue: CGRect){
        self.geometryValue = geometryValue
    }
    
    //TODO: logic when object is tapped Maybe I can add additional logic when tapped object has variant
    func tapScoreView(id: UUID){
        withAnimation(.spring()) {
            self.removeScoreView(id: id)
            self.penaltyObjects1.removeAll()
            self.penaltyObjects2.removeAll()
            self.addView()
        }
        
        if !self.isStarted{
            self.startGame()
        }
        
        self.currentCount += 1
        if self.currentCount > self.bestRecord {
            self.bestRecord = self.currentCount
            self.bestRecordUpdated = true
        }
        
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.addGameTime(time: 0.1)
    }
    
    func tapPenaltyView(id: UUID, penaltyId: Int){
        withAnimation(.spring()){
            self.removePenaltyView(id: id, penaltyId: penaltyId)
            penaltyId == 1 ? self.penaltyObjects2.removeAll() : self.penaltyObjects1.removeAll()
            self.scoreObjects.removeAll()
            self.addView()
        }
        
        guard let timerDelgate = self.timeLeftProgressViewDelegate else {return}
        timerDelgate.subtractGameTime(time: 0.1)
    }
    
    func setDifficulty(difficulty: Difficulty){
        self.difficulty = difficulty
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.setDifficulty(difficulty: difficulty)
        setBestRecordFromAppStorage()
    }
    
    func setBestRecordFromAppStorage(){
        switch self.difficulty{
        case .superEasy:
            self.bestRecord = superEasyBestRecord
            break
        case .easy:
            self.bestRecord = easyBestRecord
            break
        case .medium:
            self.bestRecord = mediumBestRecord
            break
        case .hard:
            self.bestRecord = hardBestRecord
            break
        case .superHard:
            self.bestRecord = superHardBestRecord
            break
        }
    }
    
    func setBestRecordToAppStorage(){
        switch self.difficulty{
        case .superEasy:
            superEasyBestRecord = self.bestRecord
            break
        case .easy:
            easyBestRecord = self.bestRecord
            break
        case .medium:
            mediumBestRecord = self.bestRecord
            break
        case .hard:
            hardBestRecord = self.bestRecord
            break
        case .superHard:
            superHardBestRecord = self.bestRecord
            break
        }
    }
    
    func startGame() {
        self.isStarted = true
        //        setBestRecordFromAppStorage()
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.startTimer()
        timerDelegate.getTimeout()
            .sink { [weak self] timeout in
                guard let self = self else {return}
                if timeout {
                    self.terminateGame()
                }
            }
            .store(in: &cancellable)
    }
    
    func pauseGame() {
        withAnimation {
            self.isPaused = true
        }
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.stopTimer()
    }
    
    func resumeGame() {
        self.isPaused = false
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.startTimer()
    }
    
    func terminateGame() {
        withAnimation {
            self.isTerminated = true
        }
        for c in self.cancellable{
            c.cancel()
        }
        if bestRecordUpdated {
            setBestRecordToAppStorage()
            confettiCounter = 1
        }
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.stopTimer()
    }
    
    func retryGame(){
        self.isPaused = false
        self.isTerminated = false
        self.currentCount = 0
        self.bestRecordUpdated = false
        self.confettiCounter = 0
        self.scoreObjects.removeAll()
        self.penaltyObjects1.removeAll()
        self.penaltyObjects2.removeAll()
        addView()
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.resetTimer()
        timerDelegate.startTimer()
        timerDelegate.getTimeout()
            .sink { [weak self] timeout in
                guard let self = self else {return}
                if timeout {
                    self.terminateGame()
                }
            }
            .store(in: &cancellable)
    }
    func goHome(){
        self.isStarted = false
        self.isPaused = false
        self.isTerminated = false
        self.currentCount = 0
        self.bestRecordUpdated = false
        self.confettiCounter = 0
        self.scoreObjects.removeAll()
        self.penaltyObjects1.removeAll()
        self.penaltyObjects2.removeAll()
        initializeGame()
        guard let timerDelegate = self.timeLeftProgressViewDelegate else {return}
        timerDelegate.resetTimer()
        setBestRecordFromAppStorage()
    }
    
}
