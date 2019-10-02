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

    @IBOutlet weak var titleLabel: ConversionCalcLabel!
    @IBOutlet weak var fromLabel: ConversionCalcLabel!
    @IBOutlet weak var toLabel: ConversionCalcLabel!
    @IBOutlet weak var fromUnits: ConversionCalcLabel!
    @IBOutlet weak var toUnits: ConversionCalcLabel!
    @IBOutlet weak var fromField: ConversionCalcTextField!
    @IBOutlet weak var fromDelegate: UITextFieldDelegate!
    @IBOutlet weak var toField: ConversionCalcTextField!
    @IBOutlet weak var toDelegate: UITextFieldDelegate!
    @IBOutlet weak var calcButton: ConversionCalcButton!
    @IBOutlet weak var clearButton: ConversionCalcButton!
    @IBOutlet weak var modeButton: ConversionCalcButton!
    @IBOutlet weak var settingButton: ConversionCalcButton!
    
    
    let BACKGROUND_COLOR = UIColor.init(red:0.000, green:0.369, blue:0.420,
                                    alpha:1.00) // Blueish
    let FOREGROUND_COLOR = UIColor.init(red: 0.937, green: 0.820,
    blue: 0.576, alpha: 1.0)  // Tannish
    
    
    @IBAction func changeMode(_ sender: UIButton) {
        if (mode == CalculatorMode.Length) {
            mode = CalculatorMode.Volume
            titleLabel.text = "Volume Conversion Calculator"
            fromUnits.text = volFromUnit.rawValue
            toUnits.text = volToUnit.rawValue
            fromField.placeholder = "Enter volume in \(volFromUnit.rawValue)"
            toField.placeholder = "Enter volume in \(volToUnit.rawValue)"
        } else {
            mode = CalculatorMode.Length
            titleLabel.text = "Length Conversion Calculator"
            fromUnits.text = lenFromUnit.rawValue
            toUnits.text = lenToUnit.rawValue
            fromField.placeholder = "Enter length in \(lenFromUnit.rawValue)"
            toField.placeholder = "Enter length in \(lenToUnit.rawValue)"
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
        self.view.backgroundColor = BACKGROUND_COLOR
        fromField.attributedPlaceholder = NSAttributedString(string: "Enter volume in Gallons", attributes:[NSAttributedString.Key.foregroundColor: FOREGROUND_COLOR])
        toField.attributedPlaceholder = NSAttributedString(string: "Enter volume in Liters", attributes:[NSAttributedString.Key.foregroundColor: FOREGROUND_COLOR])
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
        if (mode == CalculatorMode.Length) {
            fromField.placeholder = "Enter length in \(fromUnits)"
            toField.placeholder = "Enter length in \(toUnits)"
        } else {
            fromField.placeholder = "Enter volume in \(fromUnits)"
            toField.placeholder = "Enter volume in \(toUnits)"
        }
        
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
