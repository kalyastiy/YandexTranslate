//
//  TraslationLang.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 16.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

enum Traslation {
    case from
    case to
}

struct TraslationState {
    var language: Language
    var traslation: Traslation
}
