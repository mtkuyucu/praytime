//
//  PrayInfoViewModel.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 21.01.2023.
//

import Foundation
import SwiftUI

@MainActor
class PrayInfoViewModel : ObservableObject {
    
    @Published var prayCounter = PrayCounter()
    
    func populatePrayInfo() async {
        do{
            let prayInfo = try await PrayService().getPrayInfo(url: Constants.Urls.prayInfo)
            self.prayCounter = nextPrayTime(prayData: prayInfo)
        } catch{
            print(error)
        }
    }
    
    private func nextPrayTime(prayData:PrayData) -> PrayCounter{
        guard let prayDate:[PrayDate] = prayData.prayDates else {
            print("No Pray Dates")
            return PrayCounter()
        }
        
        let now = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
        let todayPrayDate = prayDate.first { prayDate in
            Calendar.current.isDate(prayDate.date, inSameDayAs: now)
        }
        
        var tomorrowPrayDate = prayDate.first { prayDate in
            Calendar.current.isDate(prayDate.date, inSameDayAs: tomorrow)
        }
        
        if(now < (todayPrayDate?.fajr[0].time)!){
            tomorrowPrayDate = todayPrayDate;
        }
        
        if let todayPrayDate = todayPrayDate{
            
            if(now > todayPrayDate.fajr[0].time && now < todayPrayDate.sunrise[0].time){
                return PrayCounter(prayTimeText: "pray.time.sunrise", prayTime: todayPrayDate.sunrise[0].time)
            }
            
            if(now > todayPrayDate.isha[0].time || now < todayPrayDate.fajr[0].time){
                return PrayCounter(prayTimeText: "pray.time.fajr", prayTime: tomorrowPrayDate!.fajr[0].time)
            }
            
            if(now > todayPrayDate.maghrib[0].time){
                return PrayCounter(prayTimeText: "pray.time.isha", prayTime: todayPrayDate.isha[0].time)
            }
            
            if(now > todayPrayDate.asr[0].time){
                return PrayCounter(prayTimeText: "pray.time.maghrib", prayTime: todayPrayDate.maghrib[0].time)
            }
            
            if(now > todayPrayDate.zuhr[0].time){
                return PrayCounter(prayTimeText: "pray.time.asr", prayTime: todayPrayDate.asr[0].time)
            }
            
            if(now > todayPrayDate.sunrise[0].time){
                return PrayCounter(prayTimeText: "pray.time.zuhr", prayTime: todayPrayDate.zuhr[0].time)
            }
        }
        
        return PrayCounter()
    }
}

class PrayCounter{
    var prayTimeText:String;
    var prayTime:Date?
    
    init(){
        prayTimeText = "Herhangi bir bilgi bulunamadi"
    }
    
    init(prayTimeText: String, prayTime: Date?) {
        self.prayTimeText = prayTimeText
        self.prayTime = prayTime
    }
}
