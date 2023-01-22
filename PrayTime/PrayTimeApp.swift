//
//  PrayTimeApp.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 21.01.2023.
//

import SwiftUI

@main
struct PrayTimeApp: App {
    
    @State var currentNumber:String = "1"
    @State var prayInfoModel:PrayInfoViewModel
    @State var counter = 1
    @State var prayInfo:String = ""
    
    let localizationUtils = LocalizationUtils.defaultLocalizer;
    
    init() {
        self._prayInfoModel = State(wrappedValue: PrayInfoViewModel())
        localizationUtils.setSelectedLanguage(lang: "tr")
    }
    
    var body: some Scene {
        
        MenuBarExtra {
            Button("Quit"){
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        } label: {
            Text(prayInfo)
                .onAppear(perform: {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if let nextPrayTime = prayInfoModel.prayCounter.prayTime{
                            let currentDate = Date()
                            let timeInterval = nextPrayTime.timeIntervalSince(currentDate)
                            let hours = Int(timeInterval) / 3600
                            let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 3600)) / 60
                            prayInfo = String(format:localizationUtils.stringForKey(key: prayInfoModel.prayCounter.prayTimeText), String(format: "%02d:%02d", hours,minutes))
                            if(timeInterval <= 0){
                                Task{
                                    await prayInfoModel.populatePrayInfo()
                                }
                            }
                        }else{
                            prayInfo = "Bilgi Bulunamadi"
                        }
                    }
                })
                .task {
                    await prayInfoModel.populatePrayInfo()
                }
        }
    }
}
