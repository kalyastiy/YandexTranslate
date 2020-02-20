//
//  HistoryPresenterProtocol.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation

protocol HistoryPresenterProtocol: class {

    func removeHistorys()
    func viewDidLoad()
    func viewWillAppear()
    func didEndSearch()
    func didBeginSearch(text: String)
    func didSelectHistory()

}
