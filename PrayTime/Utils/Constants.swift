//
//  Constants.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 21.01.2023.
//

import Foundation

struct Constants {
    struct Urls{
        static let prayInfo = URL(string: "https://api.fazilettakvimi.com/api/v3/gunluk/index/318/1")!
    }
    
    struct DateFormats{
        static let defaultFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let defaultFormatWitNoTime = "yyyy-MM-dd"
    }
}
