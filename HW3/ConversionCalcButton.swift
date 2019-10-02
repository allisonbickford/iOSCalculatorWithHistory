//
//  ConversionCalcButton.swift
//  HW3
//
//  Created by Allison Bickford on 9/30/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.
//

import UIKit

class ConversionCalcButton: UIButton {
    let BACKGROUND_COLOR = UIColor.init(red:0.000, green:0.369, blue:0.420,
                                    alpha:1.00) // Blueish
    let FOREGROUND_COLOR = UIColor.init(red: 0.937, green: 0.820,
        blue: 0.576, alpha: 1.0)  // Tannish
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = FOREGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }
}
