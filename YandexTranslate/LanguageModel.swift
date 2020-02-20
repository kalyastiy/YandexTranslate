//
//  LanguageModel.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 16.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

struct Language: Equatable {
    let code: String
    let name: String
}

enum Languages: CaseIterable {
    case russian
    case english
    case spain
}

extension Languages: RawRepresentable {
    
    typealias RawValue = Language

    init?(rawValue: RawValue) {
        switch rawValue {
        case Language(code: "ru", name: "Russian"): self = .russian
        case Language(code: "en", name: "English"): self = .english
        case Language(code: "es", name: "Spain"): self = .spain
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .russian: return Language(code: "ru", name: "Russian")
        case .english: return Language(code: "en", name: "English")
        case .spain: return Language(code: "es", name: "Spain")
        }
    }
}


