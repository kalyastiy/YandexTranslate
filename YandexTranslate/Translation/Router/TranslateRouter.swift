//
//  TranslationRouter.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class TranslateRouter: TranslateRouterProtocol {
    
    weak var view: TranslateViewController!
    
    func openSourceLanguage(sourceLanguage: TraslationState) {
        
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        let controller: SourceLanguageViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SourceLanguageViewController.self)) as! SourceLanguageViewController
        controller.traslationState = sourceLanguage
        view.present(controller, animated: true, completion: nil)

    }
    
}
