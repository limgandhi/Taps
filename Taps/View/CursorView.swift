//
//  CursorView.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/10.
//

import SwiftUI

struct CursorView: View {
    @StateObject var cursorViewMdoel = CursorViewModel()
    var body: some View {
        Image(systemName: "cursorarrow")
            .font(.system(size: 80,weight: .black, design: .rounded))
            .frame(width: 60,height: 90)
            .scaleEffect(cursorViewMdoel.effect ? 1.5 : 1,anchor: .bottom)
            .onAppear{
                cursorViewMdoel.startTimer()
            }
    }
}

struct CursorView_Previews: PreviewProvider {
    static var previews: some View {
        CursorView()
    }
}
