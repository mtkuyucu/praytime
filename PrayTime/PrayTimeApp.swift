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
    
    init() {
        self._prayInfoModel = State(wrappedValue: PrayInfoViewModel())
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
                            prayInfo = String(format: prayInfoModel.prayCounter.prayTimeText, "\(hours):\(minutes)")
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
