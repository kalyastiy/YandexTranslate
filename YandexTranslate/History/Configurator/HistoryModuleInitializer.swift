//
//  HistoryModuleInitializer.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class HistoryModuleInitializer: NSObject {

    @IBOutlet weak var historyViewController: HistoryViewController!

    override func awakeFromNib() {

        let configurator = HistoryModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: historyViewController)
    }

}
