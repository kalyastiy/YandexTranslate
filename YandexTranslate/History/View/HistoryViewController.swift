//
//  HistoryViewController.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 16.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, HistoryViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var historys: [HistoryTranslate] = [HistoryTranslate]()
    private var searchText = ""
    
    var presenter: HistoryPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func setUp() {
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
        
    @IBAction func removeHistory(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Внимание!", message: "Вы действительно хотите удалить всю историю?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        let okAction = UIAlertAction(title:"Да", style: .destructive, handler: { action in
            self.presenter.removeHistorys()
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateData () {
        historys = [HistoryTranslate]()
        tableView.reloadData()
    }
    
    func updateDataWithResult(_ result: [HistoryTranslate]?) {
        historys = result ?? [HistoryTranslate]()
        tableView.reloadData()
    }


}

extension HistoryViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        presenter.didEndSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        presenter.didBeginSearch(text: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        presenter.didBeginSearch(text: searchText)
    }
    
}



extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelHistory = historys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self)) as! HistoryTableViewCell
        cell.languageLabel.text = modelHistory.text
        cell.translationLabel.text = modelHistory.translate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelHistory = historys[indexPath.row]
        NotificationCenter.default.post(name: .didSelectHistory, object: modelHistory)
        presenter.didSelectHistory()
    }
    

    
    
}
