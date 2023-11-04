//
//  TapsGameView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/10.
//

import SwiftUI
import Combine

struct TapsGameView: View {
    @StateObject var tapsGame: TapsGameViewModel
    @StateObject var timeLeftProgressModel = TimeLeftProgressViewModel()
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var body: some View {
        GeometryReader { geo in
            if tapsGame.showGameView{
                if tapsGame.isStarted {
                    HStack{
                        Spacer()
                        Text(tapsGame.currentCount.description)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 100))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        Spacer()
                    }
                    .offset(y:geo.frame(in: .global).height/5)
                    HStack{
                        Spacer()
                        TimeLeftProgressView(timeLeftProgressViewModel: timeLeftProgressModel)
                            .offset(y:geo.frame(in: .global).height-40)
                        Spacer()
                    }
                    .onAppear{
                        timeLeftProgressModel.width = geo.frame(in: .global).width/4*3
                        timeLeftProgressModel.height = 20
                    }
                }
                ZStack{
                    ForEach(tapsGame.penaltyObjects1){
                        item in
                        TapsGameButtonView(tapsGame: tapsGame,tapsGameObject: item, penaltyId: 1)
                    }
                    ForEach(tapsGame.penaltyObjects2){
                        item in
                        TapsGameButtonView(tapsGame: tapsGame,tapsGameObject: item, penaltyId: 2)
                    }
                    ForEach(tapsGame.scoreObjects){
                        item in
                        TapsGameButtonView(tapsGame: tapsGame,tapsGameObject: item)
                    }
                }
                .onAppear{
                    self.tapsGame.setGeometryValue(geometryValue: geo.frame(in: .global))
                    self.tapsGame.initializeGame()
                }
                
                TapsGamePauseView(tapsGame: tapsGame)
                
                
                TapsGameResultView(tapsGame: tapsGame)
                
            }
        }
        .onAppear{
            self.tapsGame.timeLeftProgressViewDelegate = self.timeLeftProgressModel
        }
    }
}

struct TapsGameView_Previews: PreviewProvider {
    static var previews: some View {
        TapsGameView(tapsGame: TapsGameViewModel())
            .environmentObject(ThemeObject())
    }
}
