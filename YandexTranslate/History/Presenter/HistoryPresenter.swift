//
//  HistoryPresenter.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

class HistoryPresenter: HistoryPresenterProtocol, HistoryInteractorOutputProtocol {
    
    weak var view: HistoryViewProtocol!
    var interactor: HistoryInteractorInputProtocol!
    var router: HistoryRouterProtocol!

    func removeHistorys() {
        interactor.removeHistorys()
    }
    
    func viewDidLoad() {
        view.setUp()
    }
    
    func viewWillAppear() {
        interactor.loadHistoryTranslate()
    }
    
    func didRemoveHistorys(result: Bool) {
        view.updateData()
    }
    
    func didLoadHistorys(result: [HistoryTranslate]?) {
        view.updateDataWithResult(result)
    }
    
    func didEndSearch() {
        interactor.loadHistoryTranslate()
    }
    
    func didBeginSearch(text: String) {
        text.isEmpty ? interactor.loadHistoryTranslate() : interactor.searchHistoryWith(text)
    }

    func didSelectHistory() {
        router.openTranslateView()
    }
}

