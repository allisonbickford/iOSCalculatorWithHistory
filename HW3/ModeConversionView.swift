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
    var modeSel: Bool = false // change and flip - use this to control list view. true = len, false = vol
    var saveButt: Bool?
    
    @IBOutlet weak var screen: UIView!
    @IBOutlet weak var pick: UIPickerView!
    @IBOutlet weak var fromL: UILabel!
    @IBOutlet weak var toL: UILabel!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pick.isHidden = true
        self.pick.delegate = self
        self.pick.dataSource = self
        // ===================================================================================//
        
        if self.modeSel{ // ModeSel = true(length)
            
            self.pickData = ["Yards","Meters","Miles"]
        } else {
            
            self.pickData = ["Quarts","Liters","Gallons"]
        }
        
        let fromTouch = UITapGestureRecognizer(target: self, action: #selector(self.fromTouch_))
        self.fromL.addGestureRecognizer(fromTouch)
        
        let toTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.toTouch_))
        self.toL.addGestureRecognizer(toTouch)
    }
    // ===================================================================================/
    
        override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View will dissapear!")
        
        if(self.saveButt!){
            print("Changes Saved!..")
            if let d = self.delegate {
                print("Here")
                d.ChangeView(fromUnits: self.fromUnits!, toUnits: self.toUnits!)
            }
        }else{
            print("Exit without Saving!..")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pick.isHidden = true
        self.view.endEditing(true)
    }
    // ===================================================================================/
    
    
    @IBAction func cancelButt(sender: Any){
        print("Cancled!..")
        self.saveButt = false
        self.viewWillDisappear(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButt(sender: Any){
        print("Saved!..")
        self.saveButt = true
        self.viewWillDisappear(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    // ===================================================================================/
    
    @objc func fromTouch_(sender:UITapGestureRecognizer){
        fromL.text = ""
        self.labelSel = true
        pick.isHidden = false
        self.pick.becomeFirstResponder()
    }
    
    @objc func toTouch_(sender:UITapGestureRecognizer){
        toL.text = ""
        self.labelSel = false
        pick.isHidden = false
        self.pick.becomeFirstResponder()
    }
    
    }
    // ===================================================================================/

extension ModeConversionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(self.labelSel!){
            self.fromUnits = self.pickData[row]
            self.fromL.text = "\(self.fromUnits!)"
        }else{
            self.toUnits = self.pickData[row]
            self.toL.text = "\(self.toUnits!)"
        }
    }
    
}
