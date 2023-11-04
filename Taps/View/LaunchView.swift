//
//  LaunchView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/05.
//

import SwiftUI

struct LaunchView: View {
    @StateObject var launchViewModel: LaunchViewModel
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var body: some View {
        if launchViewModel.showLaunchView{
            VStack{
                if let sentences = launchViewModel.sentences, sentences.count > 0 {
                    ForEach(sentences.indices.reversed() , id: \.self) { index in
                        Text(sentences[index])
                            .font(.custom("UhBee HYUNJUNG Bold", size: 100))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(themeObject.currentTheme.colorSet.font)
                            .opacity(launchViewModel.count > index ? 0 : 1)
                            .scaleEffect(launchViewModel.count <= index ? 1 : 5)
                            .animation(.spring(), value: launchViewModel.count)
                    }
                }
            }
            .onAppear{
                launchViewModel.startTimer()
            }
        }
            
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.white)
            LaunchView(launchViewModel: LaunchViewModel())
                .environmentObject(ThemeObject(currentTheme: .day))
        }
    }
}
