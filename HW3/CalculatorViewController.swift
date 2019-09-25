//
//  CalculatorViewController.swift
//  HW3
//  Created by Allison Bickford and Tonae Patterson on 9/20/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.

// THINGS TO DO:
// 1. Get decimal text field connected to fields in volume conv
// 2. Fix list view switch in settings
// 4. DELETE THIS <--------------------------------------------------

import UIKit

class CalculatorViewController: UIViewController, ModeConversionViewDelegate {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromUnits: UILabel!
    @IBOutlet weak var toUnits: UILabel!
    @IBOutlet weak var fromField: DecimalMinusTextField!
    //@IBOutlet weak var fromFieldv: DecimalMinusTextField!
    @IBOutlet weak var fromDelegate: UITextFieldDelegate!
    @IBOutlet weak var toField: DecimalMinusTextField!
    //@IBOutlet weak var toFieldv: DecimalMinusTextField!
    @IBOutlet weak var toDelegate: UITextFieldDelegate!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    var fUnits: String?
    var tUnits: String?
     // ===================================================================================/
    
    @IBAction func calculateLen(_ sender: UIButton) {
        // If both text fields have values - display error message & erase text //
        if (!(self.fromField.text?.isEmpty)! && !(self.toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: " Both text fields cannot contain values.",
                                          message: "Please only fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear(sender)
        }
            
            // If no text fields have values - display error message //
        else if ((self.fromField.text?.isEmpty)! && (self.toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Both text fields are empty.",
                                          message: "Please fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            self.present(alert, animated: true)
    
        }
            // If the output area has values - display error message & erase text //
        else if ((self.fromField.text?.isEmpty)! && !(self.toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Both text fields cannot contain values.",
                                          message: "Please only fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            self.present(alert, animated: true)
        
        }
            // Passes all test and is valid input format //
        else {
            var first: LengthUnit = LengthUnit.Meters
            var sec: LengthUnit = LengthUnit.Meters
            
            if (self.fromUnits.text == "Meters") {
                first = LengthUnit.Meters
            }else if (self.fromUnits.text == "Yards") {
                first = LengthUnit.Yards
            }else if (self.fromUnits.text == "Miles"){
                first = LengthUnit.Miles
            }
            
            if (self.toUnits.text == "Meters") {
                sec = LengthUnit.Meters
            }else if (self.toUnits.text == "Yards") {
                sec = LengthUnit.Yards
            }else if (self.toUnits.text == "Miles"){
                sec = LengthUnit.Miles
            }
            
            let conv = LengthConversionKey(toUnits: sec, fromUnits: first)
            if let fValue = Double(self.fromField.text!) {
                self.toField.text = String(lengthConversionTable[conv]! * fValue)
            }
        }
    }
     // ===================================================================================/
    
    // Calculation for Volume //
    @IBAction func calculateVol(_ sender: UIButton) {
        // If both text fields have values - display error message & erase text //
        if (!(self.fromField.text?.isEmpty)! && !(self.toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Both text fields cannot contain values.",
                                          message: "Please only fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            self.present(alert, animated: true)
            clear(sender)

        }
            // If no text fields have values - display error message //
        else if ((self.fromField.text?.isEmpty)! && (self.toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Both text fields are empty.",
                                          message: "Please fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            self.present(alert, animated: true)
        
        }
            // If the output area has values - display error message & erase text //
        else if ((self.fromField.text?.isEmpty)! && !(self.toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Output text fields cannot contain values.",
                                          message: "Please only fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            self.present(alert, animated: true)
            //return
        }
            
            // Passed //
        else {
            
            var first: VolumeUnit = VolumeUnit.Liters
            var sec: VolumeUnit = VolumeUnit.Liters
            
            if (self.fromUnits.text == "Liters") {
                first = VolumeUnit.Liters
            }else if (self.fromUnits.text == "Gallons") {
                first = VolumeUnit.Gallons
            }else if (self.fromUnits.text == "Quarts"){
                first = VolumeUnit.Quarts
            }
            
            if (self.toUnits.text == "Liters") {
                sec = VolumeUnit.Liters
            }else if (self.toUnits.text == "Gallons") {
                sec = VolumeUnit.Gallons
            }else if (self.toUnits.text == "Quarts"){
                sec = VolumeUnit.Quarts
            }
            
            let conv = VolumeConversionKey(toUnits: sec, fromUnits: first)
            if let fValue = Double(self.fromField.text!) {
                self.toField.text = String(volumeConversionTable[conv]! * fValue)
            }
        }
    }
     // ===================================================================================/
    
    
    @IBAction func clear(_ sender: UIButton) {
        if (self.fromField.text?.isEmpty)! {
            fromField.text = ""
        }
        
        if (self.toField.text?.isEmpty)! {
            toField.text = ""
            
        }
         stopEditing()

    }
     // ===================================================================================/
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ModeConversionView {
            dest.delegate = self
            dest.modeSel = self.fromUnits.text == "Meters" || self.fromUnits.text == "Yards" || self.fromUnits.text == "Miles"
        }
    }
    
    
    func ChangeView(fromUnits: String, toUnits: String) {
        self.fromUnits.text = fromUnits
        self.toUnits.text = toUnits
    }
    
  
}
