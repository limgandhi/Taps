//
//  SettingView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/18.
//

import SwiftUI

struct SettingView: View {
    @Binding var showSettingView: Bool
    
    @EnvironmentObject var themeObject: ThemeObject
    @EnvironmentObject var settingObject: SettingObject
    
    var body: some View {
        if showSettingView{
            PopUpView {
                Text("Setting")
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
                    Button {
                        showSettingView = false
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
                    Spacer()
                }
                .padding(.all)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.systemPink)
            SettingView(showSettingView: Binding.constant(true))
                .environmentObject(ThemeObject())
                .environmentObject(SettingObject())
        }
    }
}
