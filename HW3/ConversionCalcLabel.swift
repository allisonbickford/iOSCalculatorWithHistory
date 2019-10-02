//
//  ConversionCalcLabel.swift
//  HW3
//
//  Created by Allison Bickford on 9/30/19.
//  Copyright © 2019 Allison Bickford. All rights reserved.
//

import UIKit

class ConversionCalcLabel: UILabel {
    let FOREGROUND_COLOR = UIColor.init(red: 0.937, green: 0.820,
    blue: 0.576, alpha: 1.0)  // Tannish
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        textColor = FOREGROUND_COLOR
    }
}
