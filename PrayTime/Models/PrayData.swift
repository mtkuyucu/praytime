//
//  PrayData.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 21.01.2023.
//

import Foundation


struct PrayTime: Decodable{
    enum CodingKeys:String, CodingKey{
        case time = "tarih"
    }
    var time:Date
}

struct PrayDate: Decodable{
    enum CodingKeys:String, CodingKey{
        case date = "tarih"
        case fajr = "sabah"
        case sunrise = "gunes"
        case zuhr = "ogle"
        case asr = "ikindi"
        case maghrib = "aksam"
        case isha = "yatsi"
    }

    var date:Date
    var fajr:[PrayTime]
    var sunrise:[PrayTime]
    var zuhr:[PrayTime]
    var asr:[PrayTime]
    var maghrib:[PrayTime]
    var isha:[PrayTime]
}

struct PrayData: Decodable {
    enum CodingKeys:String, CodingKey{
        case region = "bolge_adi"
        case timeZone = "bolge_saatdilimi"
        case prayDates = "vakitler"
    }
   
    init(){
        region=""
        timeZone=""
        prayDates=[]
    }
    
    var region:String?
    var timeZone:String?
    var prayDates: [PrayDate]?
}



