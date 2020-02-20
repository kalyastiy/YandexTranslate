//
//  TranslateInteractorProtocol.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol TranslateOutputInteractorProtocol: class {

    func didTranslate(model: TranslateModel)
    func didErrorTranslateText(_ text: String)

}
