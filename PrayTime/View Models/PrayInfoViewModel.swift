//
//  PrayInfoViewModel.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 21.01.2023.
//

import Foundation

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
        let todayPrayDate = prayDate.first { prayDate in
            Calendar.current.isDate(prayDate.date, inSameDayAs: now)
        }
        
        if let todayPrayDate = todayPrayDate{
            if(now > todayPrayDate.isha[0].time){
                print("Sabah Namazina Kalan Sure ?")
                return PrayCounter(prayTimeText: "Sabah Namazina Kalan Sure :%@", prayTime: todayPrayDate.sunrise[0].time)
            }
            if(now > todayPrayDate.maghrib[0].time){
                print("Yatsi Namazina Kalan Sure ?")
                return PrayCounter(prayTimeText: "Yatsi Namazina Kalan Sure :%@", prayTime: todayPrayDate.fajr[0].time)
            }
            
            if(now > todayPrayDate.asr[0].time){
                print("Aksam Namazina Kalan Sure ?")
                return PrayCounter(prayTimeText: "Aksam Namazina Kalan Sure :%@", prayTime: todayPrayDate.maghrib[0].time)
            }
            
            if(now > todayPrayDate.zuhr[0].time){
                print("Ikindi Namazina Kalan Sure ?")
                return PrayCounter(prayTimeText: "Ikindi Namazina Kalan Sure :%@", prayTime: todayPrayDate.asr[0].time)
            }
            
            if(now > todayPrayDate.sunrise[0].time){
                print("Ogle Namazina Kalan Sure ?")
                return PrayCounter(prayTimeText: "Ogle Namazina Kalan Sure :%@", prayTime: todayPrayDate.zuhr[0].time)
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
