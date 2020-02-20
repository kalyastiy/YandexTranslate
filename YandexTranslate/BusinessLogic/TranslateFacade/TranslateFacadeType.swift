//
//  TranslateFacadeType.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol TranslateFacadeType {
    
    func translateText (_ text: String, fromTranslate: Language, toTranslate: Language, completionHandler: @escaping (APIResult<TranslateModel>) -> Void)
    
}

final class TranslateFacade: TranslateFacadeType {
    
    private let storageManager: StorageManagerProtocol
    private let translateManager: APIManagerProtocol
    
    init(storageManager: StorageManagerProtocol, translateManager: APIManagerProtocol) {
        self.storageManager = storageManager
        self.translateManager = translateManager
    }
    
    func translateText (_ text: String, fromTranslate: Language, toTranslate: Language, completionHandler: @escaping (APIResult<TranslateModel>) -> Void) {

        translateManager.fetchCurrentWeatherWith(text: text, fromTranslate: fromTranslate, toTranslate: toTranslate) { [weak self] (result) in
            completionHandler(result)
            
               switch result {
                  case .Success(let translateModel):
                     self?.storageManager.saveModelToStorage (translateModel, text: text, fromLanguage: fromTranslate, toLanguage: toTranslate)
                  case .Failure: break

                 }
        
             }
    }
    
}
