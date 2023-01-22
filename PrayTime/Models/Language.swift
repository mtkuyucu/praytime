//
//  Language.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 22.01.2023.
//

import Foundation

struct Language {
    let name: String
    let identifier: String
}

let languages = [
    Language(name: "English", identifier: "en"),
    Language(name: "German", identifier: "de"),
    Language(name: "German", identifier: "tr"),
]
let defaultLanguage = Language(name: "English", identifier: "en")
