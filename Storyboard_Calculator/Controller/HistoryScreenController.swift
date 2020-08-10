//
//  HistoryScreenController.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 8/1/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryScreenController: UITableViewController {

    var operationsHistory: Results<Data>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operationsHistory?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        cell.textLabel?.text = operationsHistory?[indexPath.row].user
        cell.detailTextLabel?.text = operationsHistory?[indexPath.row].operation
        return cell
    }

    func loadData() {
        operationsHistory = realm.objects(Data.self).sorted(byKeyPath: "timestamp", ascending: true)
        tableView.reloadData()
    }
}
