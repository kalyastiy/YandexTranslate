//
//  TranslatePresenterProtocol.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol TranslatePresenterProtocol: class {

    func viewDidLoad()
    func changeFromLanguageName(_ name: String)
    func changeToLanguageName(_ name: String)
    func translateText (_ text: String, fromTranslate: Language, toTranslate: Language)
    func openSourceLanguage(sourceLanguage: TraslationState)
    func changeLanguage()

}
