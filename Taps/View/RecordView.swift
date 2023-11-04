//
//  RecordView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/14.
//

import SwiftUI

struct RecordView: View {
    @State var title = "Record"
    @StateObject var recordViewModel: RecordViewModel
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var body: some View {
        if recordViewModel.showRecordView{
            PopUpView {
                Text("Record")
                    .font(.custom("UhBee HYUNJUNG Bold", size: 50))
                    .foregroundColor(themeObject.currentTheme.colorSet.font)
                    .padding(.all)
            } content: {
                VStack(alignment: .leading){
                    HStack{
                        Image(themeObject.currentTheme == .day ?
                              "gauge_day" : "gauge_night")
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Image(themeObject.currentTheme == .day ?
                                      "hand_day" : "hand_night")
                                    .resizable()
                                    .scaledToFit()
                                    .rotationEffect(Angle(degrees: Difficulty.superEasy.handAngle), anchor: .init(x: 0.5, y: 0.9))
                            }
                        Spacer()
                        Text(recordViewModel.superEasyBestRecord.description)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 30))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .frame(height: 30)
                    }
                    Divider()
                    HStack{
                        Image(themeObject.currentTheme == .day ?
                              "gauge_day" : "gauge_night")
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Image(themeObject.currentTheme == .day ?
                                      "hand_day" : "hand_night")
                                    .resizable()
                                    .scaledToFit()
                                    .rotationEffect(Angle(degrees: Difficulty.easy.handAngle), anchor: .init(x: 0.5, y: 0.9))
                            }
                        Spacer()
                        Text(recordViewModel.easyBestRecord.description)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 30))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .frame(height: 30)
                    }
                    Divider()
                    HStack{
                        Image(themeObject.currentTheme == .day ?
                              "gauge_day" : "gauge_night")
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Image(themeObject.currentTheme == .day ?
                                      "hand_day" : "hand_night")
                                    .resizable()
                                    .scaledToFit()
                                    .rotationEffect(Angle(degrees: Difficulty.medium.handAngle), anchor: .init(x: 0.5, y: 0.9))
                            }
                        Spacer()
                        Text(recordViewModel.mediumBestRecord.description)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 30))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .frame(height: 30)
                    }
                    Divider()
                    HStack{
                        Image(themeObject.currentTheme == .day ?
                              "gauge_day" : "gauge_night")
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Image(themeObject.currentTheme == .day ?
                                      "hand_day" : "hand_night")
                                    .resizable()
                                    .scaledToFit()
                                    .rotationEffect(Angle(degrees: Difficulty.hard.handAngle), anchor: .init(x: 0.5, y: 0.9))
                            }
                        Spacer()
                        Text(recordViewModel.hardBestRecord.description)
                            .font(.custom("UhBee HYUNJUNG Bold", size: 30))
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .frame(height: 30)
                    }
                    Divider()
                    HStack{
                        Image(themeObject.currentTheme == .day ?
                              "gauge_day" : "gauge_night")
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Image(themeObject.currentTheme == .day ?
                                      "hand_day" : "hand_night")
                                    .resizable()
                                    .scaledToFit()
                                    .rotationEffect(Angle(degrees: Difficulty.superHard.handAngle), anchor: .init(x: 0.5, y: 0.9))
                            }
                        Spacer()
                        Text("1")
                            .font(.custom("UhBee HYUNJUNG Bold", size: 30))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .frame(height: 30)
                                                    
                    }
                }
                .padding(.horizontal,30)
                .padding(.all)
            } footer: {
                Button {
                    recordViewModel.showRecordView = false
                } label: {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 5))
                        .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                        .overlay {
                            Text("OK")
                                .font(.custom("UhBee HYUNJUNG Bold", size: 40))
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .foregroundColor(themeObject.currentTheme.colorSet.font)
                        }
                }
                .padding(.all)
            }
            
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.systemPink)
            RecordView(recordViewModel: RecordViewModel(showRecordView: true))
                .environmentObject(ThemeObject())
        }
    }
}
