//
//  TapsGameResultView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/17.
//

import SwiftUI
import ConfettiSwiftUI

struct TapsGameResultView: View {
    @StateObject var tapsGame: TapsGameViewModel
    @State var buttonTapped: Bool = false
    @EnvironmentObject var themeObject: ThemeObject
    var body: some View {
        if tapsGame.isTerminated {
            PopUpView {
                Text("Result")
                    .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(themeObject.currentTheme.colorSet.font)
                    .padding(.all)
            } content: {
                VStack(alignment: .center){
                    if tapsGame.bestRecordUpdated {
                        Spacer()
                        Text("New Record!")
                            .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        
                        Text("\(tapsGame.currentCount.description)")
                            .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        Spacer()
                    }
                    else{
                        Spacer()
                        Text("Your Score")
                            .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        Text("\(tapsGame.currentCount.description)")
                            .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                        Spacer()
                    }
                }
                .padding(.all)
                .confettiCannon(counter: $tapsGame.confettiCounter, num: 20,confettiSize: 10.0, rainHeight:100, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360),radius: 300,repetitions: 5,repetitionInterval: 0.05)
                .onAppear{
                    if tapsGame.bestRecordUpdated {
                        SoundUtil.instance.confettiSound()
                        VibrationUtil.instance.confettiVibration()
                    }
                }
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
                            tapsGame.retryGame()
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

struct TapsGameResultView_Previews: PreviewProvider {
    static var previews: some View {
        TapsGameResultView(tapsGame: TapsGameViewModel())
            .environmentObject(ThemeObject())
    }
}


