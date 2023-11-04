//
//  TimeLeftPrgressView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/11.
//
import SwiftUI

struct TimeLeftProgressView: View {
    @StateObject var timeLeftProgressViewModel: TimeLeftProgressViewModel
    
    @EnvironmentObject var themeObject: ThemeObject
    
    var body: some View{
        VStack{
            ProgressView(value: timeLeftProgressViewModel.timeLeft, total: 1.0)
                .progressViewStyle(TimeLeftProgressStyle(strokeColor: themeObject.currentTheme.colorSet.stroke, width: timeLeftProgressViewModel.width, height: timeLeftProgressViewModel.height, brightness: timeLeftProgressViewModel.brightness))
        }
        .onAppear{
            timeLeftProgressViewModel.startTimer()
        }
    }
}

struct TimeLeftProgressStyle: ProgressViewStyle{
    var strokeColor: Color
    var strokeLineWidth = 10.0
    var width: CGFloat
    var height: CGFloat
    var brightness: Double
    
    func makeBody(configuration: Configuration) -> some View {
        
        return ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(.pink)
                .overlay{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: strokeLineWidth)
                        .frame(width: width + strokeLineWidth, height: height+strokeLineWidth)
                        .foregroundColor(strokeColor)
                }
            
            Rectangle()
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * width, height: height)
                .foregroundColor(.yellow)
                .brightness(brightness)
        }
        .padding()
    }
}


struct TimeLeftProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLeftProgressView(timeLeftProgressViewModel: TimeLeftProgressViewModel(width: 205,height: 20,difficulty: .hard))
            .environmentObject(ThemeObject())
    }
}
