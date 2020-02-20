//
//  TranslationModuleConfigurator.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class TranslationModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TranslateViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: TranslateViewController) {

        let router = TranslateRouter()
        router.view = viewController

        let presenter = TranslatePresenter()
        presenter.view = viewController
        presenter.router = router

        let storageManager = StorageManager()
        let translateManaget = APITranslateManager()

        let interactor = TranslateInteractor()
        interactor.output = presenter
        interactor.translateFacade = TranslateFacade(storageManager: storageManager, translateManager: translateManaget)

        presenter.interactor = interactor
        viewController.presenter = presenter
    }

}
