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
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.sortIntoSections(entries: self.entries)
    }
    
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

    var tableViewData: [(sectionHeader: String, entries: [Conversion])]? {
       didSet {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
    }

   func sortIntoSections(entries: [Conversion]) {
       
       var tmpEntries : Dictionary<String,[Conversion]> = [:]
       var tmpData: [(sectionHeader: String, entries: [Conversion])] = []
       
       // partition into sections
       for entry in entries {
        let shortDate = entry.timestamp.short
           if var bucket = tmpEntries[shortDate] {
               bucket.append(entry)
               tmpEntries[shortDate] = bucket
           } else {
               tmpEntries[shortDate] = [entry]
           }
       }
       
       // breakout into our preferred array format
       let keys = tmpEntries.keys
       for key in keys {
           if let val = tmpEntries[key] {
               tmpData.append((sectionHeader: key, entries: val))
           }
       }

       // sort by increasing date.
       tmpData.sort { (v1, v2) -> Bool in
           if v1.sectionHeader < v2.sectionHeader {
               return true
           } else {
               return false
           }
       }
       
       self.tableViewData = tmpData
   }

}

protocol HistoryTableViewControllerDelegate {
    func selectEntry(entry: Conversion)
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    struct Formatter {
        static let short: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    
    var short: String {
        return Formatter.short.string(from: self)
    }
}

