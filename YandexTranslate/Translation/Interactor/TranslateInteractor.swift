//
//  TranslateInteractor.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

class TranslateInteractor: TranslateInputInteractorProtocol {

    weak var output: TranslateOutputInteractorProtocol!
    
    var translateFacade: TranslateFacadeType!

    func translateText (_ text: String, fromTranslate: Language, toTranslate: Language) {
        translateFacade.translateText(text, fromTranslate: fromTranslate, toTranslate: toTranslate) { [weak self] result in
            
          switch result {
            case .Success(let translateModel):
                self?.output.didTranslate(model: translateModel)
            case .Failure(let error as NSError):
                self?.output.didErrorTranslateText(error.localizedDescription)
             }

        }
    }
    
}
