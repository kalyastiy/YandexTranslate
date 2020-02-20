//
//  HistoryTranslate+CoreDataProperties.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 16.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//
//

import Foundation
import CoreData


extension HistoryTranslate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryTranslate> {
        return NSFetchRequest<HistoryTranslate>(entityName: "HistoryTranslate")
    }

    @NSManaged public var fromCode: String?
    @NSManaged public var fromName: String?
    @NSManaged public var text: String?
    @NSManaged public var toCode: String?
    @NSManaged public var toName: String?
    @NSManaged public var translate: String?
    
    
    var fromLanguage: Language {
      get {
        if let fromC = fromCode, let fromN = fromName {
            return Language(code: fromC, name: fromN)
        } else {
            return Languages.english.rawValue
        }
        
       }
    }
    
    var toLanguage: Language {
      get {
        if let toC = toCode, let toN = toName {
            return Language(code: toC, name: toN)
        } else {
            return Languages.russian.rawValue
        }
        
       }
    }


}
