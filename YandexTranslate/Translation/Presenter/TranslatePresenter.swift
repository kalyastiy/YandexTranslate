//
//  TranslatePresenter.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

class TranslatePresenter: TranslatePresenterProtocol, TranslateOutputInteractorProtocol {
    
    weak var view: TranslateViewProtocol!
    var interactor: TranslateInputInteractorProtocol!
    var router: TranslateRouterProtocol!

    func viewDidLoad() {
        view.setUp()
    }
    
    func changeFromLanguageName(_ name: String) {
        view.changeFromLanguageBtnName(name)
    }
    
    func changeToLanguageName(_ name: String) {
        view.changeToLanguageBtnName(name)
    }

    func translateText (_ text: String, fromTranslate: Language, toTranslate: Language) {
        interactor.translateText(text, fromTranslate: fromTranslate, toTranslate: toTranslate)
    }
    
    func didTranslate(model: TranslateModel) {
        view.didTranslate(model: model)
    }

    func openSourceLanguage(sourceLanguage: TraslationState) {
        router.openSourceLanguage(sourceLanguage: sourceLanguage)
    }
    
    func didErrorTranslateText(_ text: String) {
        view.showAlerWithTitle("Unable to get data", msg: text)
    }
    
    func changeLanguage() {
        view.changeLanguage()
    }

}

