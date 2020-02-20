//
//  StorageManagerProtocol.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 17.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit
import CoreData


protocol StorageManagerProtocol {
    
    func saveModelToStorage (_ model: TranslateModel, text: String, fromLanguage: Language, toLanguage: Language)
    func loadHistoryTranslate() -> [HistoryTranslate]?
    func removeHistorys() -> Bool
    func searchTraslation(text: String) -> [HistoryTranslate]?
    
}

final class StorageManager: StorageManagerProtocol {
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private func searchDoubleTraslationInStorage(text: String, translate: String) -> Int {
        
        let fetchRequest: NSFetchRequest<HistoryTranslate> = HistoryTranslate.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(text contains[cd] %@) && (translate contains[cd] %@)", text, translate)
        
        do {
            return try context.count(for: fetchRequest)
        }
        catch {
            print(error.localizedDescription)
            return 0
        }
    }

    
    
    func saveModelToStorage (_ model: TranslateModel, text: String, fromLanguage: Language, toLanguage: Language) {
        
        if searchDoubleTraslationInStorage(text: text, translate: model.text) == 0 {
            
            let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: context)
            let historyTranslate = NSManagedObject(entity: entity!, insertInto: context) as! HistoryTranslate
            
            historyTranslate.fromCode = fromLanguage.code
            historyTranslate.toCode = toLanguage.code
            historyTranslate.text = text
            historyTranslate.translate = model.text
            historyTranslate.fromName = fromLanguage.name
            historyTranslate.toName = toLanguage.name
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }

        }

    }
    
    func loadHistoryTranslate() -> [HistoryTranslate]? {

        let fetchRequest: NSFetchRequest<HistoryTranslate> = HistoryTranslate.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return nil
        }

    }

    
    func removeHistorys() -> Bool {
        
        let request: NSFetchRequest<HistoryTranslate> = HistoryTranslate.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }

    }
    
    func searchTraslation(text: String) -> [HistoryTranslate]? {
        
        let fetchRequest: NSFetchRequest<HistoryTranslate> = HistoryTranslate.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(text contains[cd] %@) || (translate contains[cd] %@)", text, text)
    
        do {
            return try context.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
