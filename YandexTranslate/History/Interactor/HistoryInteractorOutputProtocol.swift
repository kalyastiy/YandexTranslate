//
//  HistoryInteractorOutputProtocol.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol HistoryInteractorOutputProtocol: class {

    func didRemoveHistorys(result: Bool)
    func didLoadHistorys(result: [HistoryTranslate]?)

}
