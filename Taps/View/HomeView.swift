//
//  HomeView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/12.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel
    @StateObject var settingViewModel = SettingViewModel()
    @StateObject var recordViewModel = RecordViewModel()
    @StateObject var tapsGame = TapsGameViewModel()
    
    @StateObject var difficultyViewModel = DifficultyViewModel()
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var body: some View {
        if homeViewModel.showHomeView{
            GeometryReader{ geo in
                if !tapsGame.isStarted {
                    VStack(alignment:.center){
                        Spacer()
                        HStack(){
                            Spacer()
                            DifficultyView(difficultyViewModel: difficultyViewModel)
                                .onChange(of: difficultyViewModel.currentDifficulty) { newValue in
                                    withAnimation {
                                        tapsGame.setDifficulty(difficulty: newValue)
                                    }
                                }
                            Spacer()
                        }
                    }
                }
                
                HStack(alignment: .top,spacing: 10){
                    if !tapsGame.isStarted {
                        Button {
                            withAnimation {
                                homeViewModel.showSettingView = true
//                                settingViewModel.showSettingView = true
                            }
                        } label: {
                            Image("setting")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 50,height: 50)
                                .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                        }
                        
                        Button {
                            withAnimation {
                                themeObject.currentTheme = themeObject.currentTheme == .day ? .night : .day
                            }
                        } label: {
                            if themeObject.currentTheme == .day{
                                Image("moon")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                    .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                            }else{
                                Image("sun")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                    .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                            }
                        }
                        //TODO: Record for Multi peer connectiviey
//                        Button {
//                            withAnimation {
//                                recordViewModel.showRecordView = true
//                            }
//                        } label: {
//                            Image("record")
//                                .renderingMode(.template)
//                                .resizable()
//                                .frame(width: 40,height: 50)
//                                .foregroundColor(themeObject.currentTheme.colorSet.stroke)
//                        }
                    }else{
                        Button {
                            tapsGame.pauseGame()
                        } label: {
                            Image("pause")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                        }
                    }
                    Spacer()
                    VStack(alignment: .center){
                        Text("Best Score")
                            .lineLimit(2)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 20))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        Text(tapsGame.bestRecord.description)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 20))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .offset(CGSize(width: 0, height: -10))
                    }
                    .opacity(tapsGame.bestRecordUpdated ? 1.0:0.5)
                    .offset(CGSize(width: 0, height: -10))
                }
                .frame(height:120)
                .padding(.all)
                
                
                if !tapsGame.isStarted {
                    HStack{
                        Spacer()
                        Text("Taps")
                            .frame(width: geo.frame(in: .global).width/2)
                            .lineLimit(1)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 200))
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        Spacer()
                    }
                    .offset(y:geo.frame(in: .global).height/8)
                }
                
                TapsGameView(tapsGame: tapsGame)
                    .brightness(!tapsGame.isStarted && homeViewModel.brightEffect ? 0.15 : 0.0)
                    .onAppear{
                        tapsGame.setDifficulty(difficulty: difficultyViewModel.currentDifficulty)
                    }
                
                if !tapsGame.isStarted {
                    ZStack{
                        VStack(alignment: .center,spacing: 0){
                            Image("arrow-up")
                                .renderingMode(.template)
                                .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                            Text("Tap to Start!")
                                .frame(width: geo.frame(in: .global).width/2)
                                .font(.custom("UhBee HYUNJUNG Bold", size: 40))
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .foregroundColor(themeObject.currentTheme.colorSet.font)
                        }
                        .frame(width: geo.frame(in: .global).width)
                        .offset(CGSize(width: 0, height: geo.frame(in: .global).height/2 + geo.frame(in: .global).width/8 + 10))
                                
                        
                    }
                    
                }
                
                SettingView(showSettingView: $homeViewModel.showSettingView)
                
//                RecordView(recordViewModel: recordViewModel)
            }
            .onAppear{
                homeViewModel.startTimer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel(showHomeView: true))
            .environmentObject(ThemeObject())
            .environmentObject(SettingObject())
    }
}
