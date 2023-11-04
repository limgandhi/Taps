//
//  RecordViewModel.swift
//  Taps
//
//  Created by Hyunyou Lim on 2023/08/14.
//

import SwiftUI

class RecordViewModel: ObservableObject {
    
    @Published var showRecordView: Bool
    @AppStorage("superEasyBestRecord") var superEasyBestRecord = 0
    @AppStorage("easyBestRecord") var easyBestRecord = 0
    @AppStorage("mediumBestRecord") var mediumBestRecord = 0
    @AppStorage("hardBestRecord") var hardBestRecord = 0
    @AppStorage("superHardBestRecord") var superHardBestRecord = 0
    
    init(showRecordView: Bool = false) {
        self.showRecordView = showRecordView
    }
}
