//
//  LocalizationUtils.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 22.01.2023.
//

import Foundation

class LocalizationUtils: NSObject {

    static let defaultLocalizer = LocalizationUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            appbundle = Bundle.main
            return
        }
        appbundle = Bundle(path: langPath)!
    }
    
    func stringForKey(key: String) -> String {
        return appbundle.localizedString(forKey: key, value: "", table: nil)
    }
}
