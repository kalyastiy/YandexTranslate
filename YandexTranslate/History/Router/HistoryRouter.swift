//
//  HistoryRouter.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class HistoryRouter: HistoryRouterProtocol {
    
    weak var view: HistoryViewController!
    
    func openTranslateView() {
        view.tabBarController?.selectedIndex = 0
    }
        
}
