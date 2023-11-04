//
//  PopUpView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/16.
//

import SwiftUI

//TODO: insert GameSettingView or GameResultView in Popup view via View Builder
struct PopUpView<Header:View, Body: View, Footer: View>: View{
    let headerContent: Header
    let bodyContent: Body
    let footerContent: Footer
    
    @EnvironmentObject var themeObject: ThemeObject
    
    init(@ViewBuilder header: () -> Header,
         @ViewBuilder content: () -> Body,
         @ViewBuilder footer: () -> Footer) {
        self.headerContent = header()
        self.bodyContent = content()
        self.footerContent = footer()
    }
    
    var body: some View{
        ZStack{
            Color(themeObject.currentTheme == .day ? .white : .black)
                .opacity(0.5)
                .ignoresSafeArea(.all)
        }.overlay(content: {
            GeometryReader { geo in
                let rectWidth = geo.frame(in: .global).width*3/4
                let rectHeight = geo.frame(in: .global).height*3/5
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(themeObject.currentTheme.colorSet.background)
                            .frame(width: rectWidth, height: rectHeight+20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle(lineWidth: 10))
                                    .foregroundColor(themeObject.currentTheme.colorSet.stroke)
                                VStack(spacing:0){
                                    headerContent
                                        .frame(height: rectHeight/5)
                                    Divider()
                                        .frame(height:10)
                                        .background(themeObject.currentTheme.colorSet.stroke)
                                    bodyContent
                                        .frame(height: rectHeight/5*3)
                                    Divider()
                                        .frame(height:10)
                                        .background(themeObject.currentTheme.colorSet.stroke)
                                    footerContent
                                        .frame(height: rectHeight/5)
                                }
                            }
                        Spacer()
                    }
                    Spacer()
                }
            }
        })
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView {
            ZStack{
                //                Color(.yellow)
                Text("Header")
            }
        } content: {
            ZStack{
                //                Color(.yellow)
                Text("Content")
            }
        } footer: {
            ZStack{
                //                Color(.yellow)
                HStack{
                    Text("Footer")
                }
            }
        }
        .environmentObject(ThemeObject())
    }
}
