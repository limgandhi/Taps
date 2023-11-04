//
//  TapsObject.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/07/12.
//

import SwiftUI

class TapsObject: ObservableObject, Identifiable {
    var id = UUID()
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    var opacity: Double
    var scale: Double
    var blur: CGFloat
    var offset: CGSize
    var color: Color
    var overlayX: Bool
    var disable: Bool
    
    init(frameWidth: CGFloat = 100,
         frameHeight: CGFloat = 100,
         opacity: Double = 1.0,
         scale: Double = 1.0,
         blur: CGFloat = 0.0,
         offset: CGSize = .zero,
         color: Color = .yellow,
         overlayx: Bool = false,
         disable: Bool = false){
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.opacity = opacity
        self.scale = scale
        self.blur = blur
        self.offset = offset
        self.color = color
        self.overlayX = overlayx
        self.disable = disable
    }
    
    func setColor(color: Color)->Self{
        self.color = color
        return self
    }
}
