//
//  TapsGamePauseView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/17.
//

import SwiftUI

struct TapsGamePauseView: View {
    @StateObject var tapsGame: TapsGameViewModel
    @State var buttonTapped = false
    @EnvironmentObject var themeObject: ThemeObject
    @EnvironmentObject var settingObject: SettingObject
    
    var body: some View {
        if tapsGame.isPaused {
            PopUpView {
                Text("Pause")
                    .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(themeObject.currentTheme.colorSet.font)
                    .padding(.all)
            } content: {
                VStack{
                    Toggle("Sound", isOn: $settingObject.soundIsChecked)
                        .toggleStyle(CustomToggleStyle(fontColor: themeObject.currentTheme.colorSet.font, strokeColor: themeObject.currentTheme.colorSet.stroke))
                        .padding(.horizontal)
                    Toggle("Vibration", isOn: $settingObject.vibrationIsChecked)
                        .toggleStyle(CustomToggleStyle(fontColor: themeObject.currentTheme.colorSet.font, strokeColor: themeObject.currentTheme.colorSet.stroke))
                        .padding(.horizontal)
                }
                .padding(.all)
            } footer: {
                HStack{
                    Spacer()
                    Button{
                        if !buttonTapped{
                            buttonTapped = true
                            tapsGame.goHome()
                        }
                    }label: {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 5))
                            .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                            .overlay {
                                Image("home")
                                    .renderingMode(.template)
                                    .resizable()
                                    .padding(10)
                                    .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                            }
                    }
                    Spacer()
                    Button {
                        if !buttonTapped{
                            buttonTapped = true
                            tapsGame.resumeGame()
                        }
                    } label: {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 5))
                            .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                            .overlay {
                                Image("retry")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                                    .padding(10)
                            }
                    }
                    Spacer()
                }
                .padding(.all)
                .onAppear{
                    buttonTapped = false
                }
            }
        }
    }
}

struct TapsGamePauseView_Previews: PreviewProvider {
    static var previews: some View {
        TapsGamePauseView(tapsGame: TapsGameViewModel())
            .environmentObject(ThemeObject())
    }
}
