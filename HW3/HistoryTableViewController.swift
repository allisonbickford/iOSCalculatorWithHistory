//
//  HistoryTableViewController.swift
//  HW3
//
//  Created by Allison Bickford on 10/28/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewController: UITableViewController {
    var entries: [Conversion] = []
    var historyDelegate:HistoryTableViewControllerDelegate?
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = "\(entries[indexPath.row].fromVal) \(entries[indexPath.row].fromUnits) = \(entries[indexPath.row].toVal) \(entries[indexPath.row].toUnits)"
        cell.detailTextLabel?.text = "\(entries[indexPath.row].timestamp)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // use the historyDelegate to report back entry selected to the calculator scene
       if let del = self.historyDelegate {
           let conv = entries[indexPath.row]
           del.selectEntry(entry: conv)
       }
       
       // this pops back to the main calculator
       _ = self.navigationController?.popViewController(animated: true)
   }
}

protocol HistoryTableViewControllerDelegate {
    func selectEntry(entry: Conversion)
}
