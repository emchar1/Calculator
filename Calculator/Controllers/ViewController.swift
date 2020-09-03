//
//  ViewController.swift
//  Calculator
//
//  Created by Eddie Char on 9/3/20.
//  Copyright © 2020 Eddie Char. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!

    private var calculator = CalculatorLogic(maxDigits: 12)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel.text = "0"
    }

    @IBAction func calcPressed(_ sender: UIButton) {
        calculator.performOperation(with: sender.currentTitle!, on: &displayLabel.text!)
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        calculator.enterNums(append: sender.currentTitle!, to: &displayLabel.text!)
    }
    

}
