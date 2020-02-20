//
//  TranslationModuleInitializer.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class TranslationModuleInitializer: NSObject {

    @IBOutlet weak var translationViewController: TranslateViewController!

    override func awakeFromNib() {

        let configurator = TranslationModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: translationViewController)
    }

}
