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
    @IBOutlet weak var fromField: DecimalMinusTextField!
    @IBOutlet weak var fromDelegate: UITextFieldDelegate!
    @IBOutlet weak var toField: DecimalMinusTextField!
    @IBOutlet weak var toDelegate: UITextFieldDelegate!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    
    var fUnits: String?
    var tUnits: String?
    
    @IBAction func calculate(_ sender: UIButton) {
        if (fromField.text != "") {
            let result: Double = Double(fromField.text!)! * 0.9144
            toField.text = "\(round(result * 100000) / 100000)" // some rounding to prevent a million decimals
            stopEditing()
        } else if (toField.text != "") {
            let result: Double = Double(toField.text!)! * 1.09361
            fromField.text = "\(round(result * 100000) / 100000)"
            stopEditing()
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        fromField.text = ""
        toField.text = ""
        stopEditing()
    }
    
    @IBAction func mode(_ sender: UIButton) {
        // TODO
        stopEditing()
    }
    
    @IBAction func clearTheOther(textField: DecimalMinusTextField) {
        if (textField == fromField) {
            toField.text = ""
        } else {
            fromField.text = ""
        }
    }
    
    func stopEditing() {
        fromField.endEditing(true)
        toField.endEditing(true)
        view.endEditing(true)
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
