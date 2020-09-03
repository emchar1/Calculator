//
//  numberButton.swift
//  Calculator
//
//  Created by Eddie Char on 9/3/20.
//  Copyright © 2020 Eddie Char. All rights reserved.
//

import UIKit

class numberButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let minLength = max(bounds.width, bounds.height)
        print(bounds.width)
        print(bounds.height)
        backgroundColor = .red
        layer.cornerRadius = 0.5 * minLength - 0.06 * minLength
        print(layer.cornerRadius)
        bounds.size.height = minLength
//        frame.size = CGSize(width: minLength, height: minLength)
        clipsToBounds = true
    }
    

}
