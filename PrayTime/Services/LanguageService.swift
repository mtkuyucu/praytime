//
//  LanguageService.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 22.01.2023.
//

import Foundation

class LocalizationService {
    
    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")
    
    private init() {}
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
                return defaultLanguage
            }
            return languages.first(where: { lang in
                lang.identifier == languageString
            }) ?? defaultLanguage
        } set {
            if newValue.identifier != language.identifier {
                UserDefaults.standard.setValue(newValue.identifier, forKey: "language")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
