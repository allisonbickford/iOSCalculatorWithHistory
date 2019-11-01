//
//  ModeConversion.swift
//  HW3
//
//  Created by Allison Bickford and Tonae Patterson on 9/20/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.
//

import UIKit

protocol ModeConversionViewDelegate {
    func ChangeView(fromUnits: String, toUnits: String)
}

class ModeConversionView: UIViewController{
    
    var pickData: [String] = [String]()
    var delegate: ModeConversionViewDelegate?
    var labelSel: Bool?
    
    var fromUnits: String?
    var toUnits: String?
    var isLength: Bool = false // change and flip - use this to control list view. true = len, false = vol
    var isPickingFromUnits: Bool = true
    
    @IBOutlet weak var screen: UIView!
    @IBOutlet weak var pick: UIPickerView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pick.isHidden = true
        pick.delegate = self
        pick.dataSource = self
        
        if isLength {
            pickData = ["Yards","Meters","Miles"]
        } else {
            
            pickData = ["Quarts","Liters","Gallons"]
        }
        fromLabel.text! = fromUnits!
        toLabel.text! = toUnits!
        
        let fromTouch = UITapGestureRecognizer(target: self, action: #selector(fromTouch_))
        fromLabel.addGestureRecognizer(fromTouch)
        
        let toTouch = UITapGestureRecognizer(target: self, action:
            #selector(toTouch_))
        toLabel.addGestureRecognizer(toTouch)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let d = delegate {
            d.ChangeView(fromUnits: fromUnits!, toUnits: toUnits!)
        }
    }
    
    @IBAction func closeSettings(sender: UIButton!) {
        viewWillDisappear(true)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func fromTouch_(sender:UITapGestureRecognizer){
        isPickingFromUnits = true
        pick.isHidden = false
        let pickedIndex = pickData.firstIndex(of: fromUnits!)
        pick.selectRow(pickedIndex!, inComponent: 0, animated: true)
    }
    
    @IBAction func toTouch_(sender:UITapGestureRecognizer){
        isPickingFromUnits = false
        pick.isHidden = false
        let pickedIndex = pickData.firstIndex(of: toUnits!)
        pick.selectRow(pickedIndex!, inComponent: 0, animated: true)
    }
    
}

extension ModeConversionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (isPickingFromUnits) {
            fromLabel.text = pickData[row]
            fromUnits = pickData[row]
        } else {
            toLabel.text = pickData[row]
            toUnits = pickData[row]
        }
    }
    
}
