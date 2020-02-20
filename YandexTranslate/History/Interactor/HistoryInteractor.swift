//
//  HistoryInteractor.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

class HistoryInteractor: HistoryInteractorInputProtocol {

    weak var output: HistoryInteractorOutputProtocol!
    
    var storageManager: StorageManagerProtocol!
    
    func removeHistorys() {
        return output.didRemoveHistorys(result: storageManager.removeHistorys())
    }
    
    func loadHistoryTranslate() {
        return output.didLoadHistorys(result: storageManager.loadHistoryTranslate())
    }
    
    func searchHistoryWith(_ text: String) {
        return output.didLoadHistorys(result: storageManager.searchTraslation(text: text))
    }


}
