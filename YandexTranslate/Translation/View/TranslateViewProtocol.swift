//
//  TranslationViewInput.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol TranslateViewProtocol: class {
    
    func setUp()
    func changeFromLanguageBtnName (_ name: String)
    func changeToLanguageBtnName (_ name: String)
    func didTranslate(model: TranslateModel)
    func showAlerWithTitle(_ title: String, msg: String)
    func changeLanguage()
}

