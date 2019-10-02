//
//  ConversionCalcTextField.swift
//  HW3
//
//  Created by Allison Bickford on 9/30/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.
//

import UIKit

class ConversionCalcTextField : DecimalMinusTextField {
    let BACKGROUND_COLOR = UIColor.init(red:0.000, green:0.369, blue:0.420,
                                    alpha:1.00) // Blueish
    let FOREGROUND_COLOR = UIColor.init(red: 0.937, green: 0.820,
        blue: 0.576, alpha: 1.0)  // Tannish
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.textColor = FOREGROUND_COLOR
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5.0
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        super.drawPlaceholder(in: rect)
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: FOREGROUND_COLOR])
    }
}
