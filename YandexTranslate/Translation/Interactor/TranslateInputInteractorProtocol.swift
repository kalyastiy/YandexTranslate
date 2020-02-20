//
//  TranslateInteractorInProtocol.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol TranslateInputInteractorProtocol {

    func translateText (_ text: String, fromTranslate: Language, toTranslate: Language)

}
