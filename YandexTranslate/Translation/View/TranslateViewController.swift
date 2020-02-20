//
//  ViewController.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 14.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit
import CoreData

class TranslateViewController: UIViewController, TranslateViewProtocol {
            
    @IBOutlet weak var textFieldEnterText: UITextField!
    @IBOutlet weak var textViewTranslation: UITextView!
    @IBOutlet weak var fromLanguageButton: UIButton!
    @IBOutlet weak var toLanguageButton: UIButton!
        
    var presenter: TranslatePresenterProtocol!
    
    private var fromLanguage = Languages.english.rawValue {
        willSet (newValue) {
            presenter.changeFromLanguageName(newValue.name)
        }
    }
    private var toLanguage = Languages.russian.rawValue {
        willSet (newValue) {
            presenter.changeToLanguageName(newValue.name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @IBAction func changeFromLanguage(_ sender: UIButton) {
        presenter.openSourceLanguage(sourceLanguage: TraslationState(language: fromLanguage, traslation: .from))
    }
    
    
    @IBAction func changeToLanguage(_ sender: UIButton) {
        presenter.openSourceLanguage(sourceLanguage: TraslationState(language: toLanguage, traslation: .to))
    }

    
    @IBAction func changeLanguage(_ sender: UIButton) {
        presenter.changeLanguage()
    }
    
    func setUp() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeStateLanguage(_:)),
                                                     name: .changeStateLanguage,
                                                     object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectHistory(_:)),
                                               name: .didSelectHistory,
                                               object: nil)

    }

    func changeFromLanguageBtnName (_ name: String) {
        fromLanguageButton.setTitle(name, for: .normal)
    }
    
    func changeToLanguageBtnName (_ name: String) {
        toLanguageButton.setTitle(name, for: .normal)
    }
    
    func showAlerWithTitle (_ title: String, msg: String) {
        
           let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           self.present(alertController, animated: true, completion: nil)

    }
    
    @objc func changeStateLanguage(_ notification: Notification) {
        
        guard let traslationState = notification.object as? TraslationState else { return }
        
        switch traslationState.traslation {
        case .to:
            self.toLanguage = traslationState.language
        case .from:
            self.fromLanguage = traslationState.language
        }
        
        clearTextViews()
    }

    @objc func didSelectHistory(_ notification: Notification) {
        
        guard let history = notification.object as? HistoryTranslate else {
            return
        }
        
        textViewTranslation.text = history.translate
        textFieldEnterText.text = history.text
        fromLanguage = history.fromLanguage
        toLanguage = history.toLanguage

    }
    
    func changeLanguage() {
        let tempLanguage = fromLanguage
        fromLanguage = toLanguage
        toLanguage = tempLanguage
        clearTextViews()
    }
    
    private func clearTextViews () {
        
        textFieldEnterText.text = ""
        textViewTranslation.text = ""

    }
    
    func didTranslate(model: TranslateModel) {
         textViewTranslation.text = model.text
    }

}


extension TranslateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            presenter.translateText(text, fromTranslate: fromLanguage, toTranslate: toLanguage)
        }
        return true
    }

}



