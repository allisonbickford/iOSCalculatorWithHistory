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
    
    var mode: CalculatorMode = CalculatorMode.Volume
    
    var volFromUnit = VolumeUnit.Gallons
    var volToUnit = VolumeUnit.Liters
    
    var lenFromUnit = LengthUnit.Miles
    var lenToUnit = LengthUnit.Meters

    @IBOutlet weak var titleLabel: UILabel!
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
    @IBOutlet weak var settingButton: UIButton!
    
    @IBAction func changeMode(_ sender: UIButton) {
        if (mode == CalculatorMode.Length) {
            mode = CalculatorMode.Volume
            titleLabel.text = "Volume Conversion Calculator"
            fromUnits.text = volFromUnit.rawValue
            toUnits.text = volToUnit.rawValue
        } else {
            mode = CalculatorMode.Length
            titleLabel.text = "Length Conversion Calculator"
            fromUnits.text = lenFromUnit.rawValue
            toUnits.text = lenToUnit.rawValue
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if (mode == CalculatorMode.Length) {
            calculateLen()
        } else {
            calculateVol()
        }
    }
    
    func calculateLen() {
        // If no text fields have values - display error message //
        if ((fromField.text?.isEmpty)! && (toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Both text fields are empty.",
                                          message: "Please fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            present(alert, animated: true)
        }
            // Passes all test and is valid input format //
        else {
            var first: LengthUnit = LengthUnit.Meters
            var sec: LengthUnit = LengthUnit.Meters
            
            if (fromUnits.text == "Meters") {
                first = LengthUnit.Meters
            } else if (fromUnits.text == "Yards") {
                first = LengthUnit.Yards
            } else if (fromUnits.text == "Miles"){
                first = LengthUnit.Miles
            }
            
            if (toUnits.text == "Meters") {
                sec = LengthUnit.Meters
            } else if (toUnits.text == "Yards") {
                sec = LengthUnit.Yards
            } else if (toUnits.text == "Miles"){
                sec = LengthUnit.Miles
            }
            
            let conv = LengthConversionKey(toUnits: sec, fromUnits: first)
            if let fValue = Double(fromField.text!) {
                toField.text = String(lengthConversionTable[conv]! * fValue)
            }
        }
    }
    
    // Calculation for Volume //
    func calculateVol() {
        // If no text fields have values - display error message //
        if ((fromField.text?.isEmpty)! && (toField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Both text fields are empty.",
                                          message: "Please fill the first entry box!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close Alert", style: .default, handler: nil))
            present(alert, animated: true)
        
        }
            
            // Passed //
        else {
            
            var first: VolumeUnit = VolumeUnit.Liters
            var sec: VolumeUnit = VolumeUnit.Liters
            
            if (fromUnits.text == "Liters") {
                first = VolumeUnit.Liters
            }else if (fromUnits.text == "Gallons") {
                first = VolumeUnit.Gallons
            }else if (fromUnits.text == "Quarts"){
                first = VolumeUnit.Quarts
            }
            
            if (toUnits.text == "Liters") {
                sec = VolumeUnit.Liters
            }else if (toUnits.text == "Gallons") {
                sec = VolumeUnit.Gallons
            }else if (toUnits.text == "Quarts"){
                sec = VolumeUnit.Quarts
            }
            
            let conv = VolumeConversionKey(toUnits: sec, fromUnits: first)
            if let fValue = Double(fromField.text!) {
                toField.text = String(volumeConversionTable[conv]! * fValue)
            }
        }
    }
     // ===================================================================================/
    
    
    @IBAction func clear(_ sender: UIButton) {
        if !(fromField.text?.isEmpty)! {
            fromField.text = ""
        }
        
        if !(toField.text?.isEmpty)! {
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
            dest.isLength = mode == CalculatorMode.Length
            dest.fromUnits = fromUnits.text!
            dest.toUnits = toUnits.text!
        }
    }
    
    
    func ChangeView(fromUnits: String, toUnits: String) {
        self.fromUnits.text = fromUnits
        self.toUnits.text = toUnits
        
        // persist previous chosen units
        if (mode == CalculatorMode.Length) {
            switch (fromUnits) {
            case "Meters":
                lenFromUnit = LengthUnit.Meters
                break
            case "Miles":
                lenFromUnit = LengthUnit.Miles
                break
            default:
                lenFromUnit = LengthUnit.Yards
            }
            switch (toUnits) {
            case "Meters":
                lenToUnit = LengthUnit.Meters
                break
            case "Miles":
                lenToUnit = LengthUnit.Miles
                break
            default:
                lenToUnit = LengthUnit.Yards
            }
        } else {
            switch (fromUnits) {
            case "Liters":
                volFromUnit = VolumeUnit.Liters
                break
            case "Gallons":
                volFromUnit = VolumeUnit.Gallons
                break
            default:
                volFromUnit = VolumeUnit.Quarts
            }
            switch (toUnits) {
            case "Liters":
                volToUnit = VolumeUnit.Liters
                break
            case "Gallons":
                volToUnit = VolumeUnit.Gallons
                break
            default:
                volToUnit = VolumeUnit.Quarts
            }
        }
    }
    
  
}
