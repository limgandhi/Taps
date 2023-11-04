//
//  CustomToggleStyle.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/10/03.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    var fontColor: Color
    var strokeColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
                .font(.custom("UhBee HYUNJUNG Bold", size: 30))
                .scaledToFit()
                .minimumScaleFactor(0.1)
                .foregroundColor(fontColor)
            
            Spacer()
            
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 5)
                    .frame(width: 25, height: 25)
                    .foregroundColor(strokeColor)
                    .overlay {
                        if configuration .isOn {
                            Image("check")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30,height: 30)
                                .offset(CGSize(width: 0, height: -10))
                                .foregroundColor(strokeColor)
                        }
                    }
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
        }
    }
}
