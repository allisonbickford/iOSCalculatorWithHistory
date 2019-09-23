//
//  CalculatorViewController.swift
//  HW3
//
//  Created by Allison Bickford on 9/20/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromUnits: UILabel!
    @IBOutlet weak var toUnits: UILabel!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    
    var fUnits: String?
    var tUnits: String?
    
    @IBAction func calculate(_ sender: UIButton) {
        
    }
    
    @IBAction func clear(_ sender: UIButton) {
        fromField.text = ""
        toField.text = ""
    }
    
    @IBAction func mode(_ sender: UIButton) {
        // TODO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromField.placeholder = "Enter length in Yards"
        fromField.clearButtonMode = UITextField.ViewMode.whileEditing
        toField.placeholder = "Enter length in Meters"
        toField.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
