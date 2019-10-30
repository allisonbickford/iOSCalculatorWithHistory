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

class CalculatorViewController: UIViewController, ModeConversionViewDelegate, HistoryTableViewControllerDelegate {
    
    var mode: CalculatorMode = CalculatorMode.Volume
    var entries : [Conversion] = [
            Conversion(fromVal: 1, toVal: 1760, mode: .Length, fromUnits: LengthUnit.Miles.rawValue, toUnits:
    LengthUnit.Yards.rawValue, timestamp: Date.distantPast),
            Conversion(fromVal: 1, toVal: 4, mode: .Volume, fromUnits: VolumeUnit.Gallons.rawValue, toUnits:
    VolumeUnit.Quarts.rawValue, timestamp: Date.distantFuture)]
    
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
        // determine source value of data for conversion and dest value for conversion
        var dest : UITextField?

        var val = ""
        var toVal = 0.0
        if let fromVal = fromField.text {
            if fromVal != "" {
                val = fromVal
                dest = toField
            }
        }
        if let toVal = toField.text {
            if toVal != "" {
                val = toVal
                dest = fromField
            }
        }
        if dest != nil {
            switch(mode) {
            case .Length:
                var fUnits, tUnits : LengthUnit
                if dest == toField {
                    fUnits = LengthUnit(rawValue: fromUnits.text!)!
                    tUnits = LengthUnit(rawValue: toUnits.text!)!
                } else {
                    fUnits = LengthUnit(rawValue: toUnits.text!)!
                    tUnits = LengthUnit(rawValue: fromUnits.text!)!
                }
                if let fromVal = Double(val) {
                    let convKey =  LengthConversionKey(toUnits: tUnits, fromUnits: fUnits)
                    toVal = fromVal * lengthConversionTable[convKey]!;
                    dest?.text = "\(toVal)"
                    
                    entries.append(Conversion(
                        fromVal: fromVal,
                        toVal: toVal,
                        mode: mode,
                        fromUnits: "\(fUnits)",
                        toUnits: "\(tUnits)",
                        timestamp: Date())
                    )
                }
            case .Volume:
                var fUnits, tUnits : VolumeUnit
                if dest == toField {
                    fUnits = VolumeUnit(rawValue: fromUnits.text!)!
                    tUnits = VolumeUnit(rawValue: toUnits.text!)!
                } else {
                    fUnits = VolumeUnit(rawValue: toUnits.text!)!
                    tUnits = VolumeUnit(rawValue: fromUnits.text!)!
                }
                if let fromVal = Double(val) {
                    let convKey =  VolumeConversionKey(toUnits: tUnits, fromUnits: fUnits)
                    toVal = fromVal * volumeConversionTable[convKey]!;
                    dest?.text = "\(toVal)"
                    
                    entries.append(Conversion(
                        fromVal: fromVal,
                        toVal: toVal,
                        mode: mode,
                        fromUnits: "\(fUnits)",
                        toUnits: "\(tUnits)",
                        timestamp: Date())
                    )
                }
            }
        }
        self.view.endEditing(true)
    }
    
    
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
        if segue.identifier == "settingsSegue" {
            if let dest = segue.destination as? ModeConversionView {
                dest.delegate = self
                dest.isLength = mode == CalculatorMode.Length
                dest.fromUnits = fromUnits.text!
                dest.toUnits = toUnits.text!
            }
        } else if (segue.identifier == "historySegue") {
            if let dest = segue.destination as? HistoryTableViewController {
                dest.entries = entries
                dest.historyDelegate = self
            }
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
    
    func selectEntry(entry: Conversion) {
        fromUnits.text! = entry.fromUnits
        fromField.text! = "\(entry.fromVal)"
        toUnits.text! = entry.toUnits
        toField.text! = "\(entry.toVal)"
        
        if (entry.fromUnits == "Meters" || entry.fromUnits == "Miles" || entry.fromUnits == "Yards") {
            if (mode == CalculatorMode.Volume) {
                changeMode(UIButton())
            }
        } else {
            if (mode == CalculatorMode.Length) {
                changeMode(UIButton())
            }
        }
        
    }
}
