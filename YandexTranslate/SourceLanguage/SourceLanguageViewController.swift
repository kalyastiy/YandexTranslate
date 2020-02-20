//
//  SourceLanguageViewController.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 16.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class SourceLanguageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var traslationState : TraslationState?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: String(describing: SourceLanguageTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SourceLanguageTableCell.self))

    }
    
    @IBAction func closeViewController(_ sender: UIButton) {
        self.dismiss(animated: false) {}
    }
    
}


extension SourceLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Languages.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelHistory = Languages.allCases[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SourceLanguageTableCell.self)) as! SourceLanguageTableCell
        cell.configurateWithText(modelHistory.rawValue.name, isBold: modelHistory.rawValue == traslationState!.language)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let language = Languages.allCases[indexPath.row]
        traslationState?.language = language.rawValue
        NotificationCenter.default.post(name: .changeStateLanguage, object: traslationState)
        dismiss(animated: true, completion: nil)
    }
    
    
}
