//
//  HistoryModuleConfigurator.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class HistoryModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HistoryViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: HistoryViewController) {

        let router = HistoryRouter()
        router.view = viewController

        let presenter = HistoryPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = HistoryInteractor()
        interactor.output = presenter
        interactor.storageManager = StorageManager()

        presenter.interactor = interactor
        viewController.presenter = presenter
    }

}
