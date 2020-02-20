//
//  TranslateModel.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 14.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import Foundation
import UIKit

struct TranslateModel {
  let code: Int
  let langFrom: String
  let langTo: String
  let text: String
}

extension TranslateModel: JSONDecodable {
    
  init?(JSON: [String : AnyObject]) {
    guard let code = JSON["code"] as? Int,
    let lang = JSON["lang"] as? String,
    let text = JSON["text"] as? [String]  else {
        return nil
    }
    
    self.code = code
    self.text = text.joined(separator:" ")

    let cpmponentsLanguage = lang.components(separatedBy: "-")
    guard cpmponentsLanguage.count == 2 else {
        self.langFrom  = ""
        self.langTo = ""
        return
    }
    
    self.langFrom  = cpmponentsLanguage[0]
    self.langTo = cpmponentsLanguage[1]

  }
}
