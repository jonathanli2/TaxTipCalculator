//
//  ViewController.swift
//  TipCalculator
//
//  Created by Li, Jonathan on 4/5/15.
//  Copyright (c) 2015 It21Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmount: UILabel!
    
    @IBOutlet weak var taxPercent: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var taxStep: UIStepper!
    
    @IBOutlet weak var tipPercent: UILabel!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var tipStep: UIStepper!
    
    @IBOutlet weak var totalAmount: UILabel!
 
    @IBOutlet weak var splitByLabel: UILabel!
    @IBOutlet weak var splitByNumber: UILabel!
    @IBOutlet weak var splitByStep : UIStepper!
    
    
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var perPersonAmount: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!

    @IBAction func onResetClicked(_ sender: Any) {
        taxStep.value = 13;
        tipStep.value = 13;
        splitByStep.value = 1

        inputTextField.text = ""
        refreshAll(self)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        UIApplication.shared.isStatusBarHidden = true
        inputTextField.becomeFirstResponder()

        // Do any additional setup after loading the view, typically from a nib.
        refreshAll(inputTextField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onStepChanged(_ sender: AnyObject) {
        refreshAll(sender)
    }
    
    func formatAsCurrency(_ number: NSNumber) -> String {
                return NumberFormatter.localizedString(
                    from: number, number: NumberFormatter.Style.currency)
    }
    
    @IBAction func billAmountChanged(_ sender: AnyObject) {
        refreshAll(sender)
    }
    
    func refreshAll(_ sender: AnyObject){
        //update input amount
            let tax = Int(taxStep.value)
            taxPercent.text = String(format: "Tax at %d%@", tax, "%");
        
            let tip = Int(tipStep.value)
            tipPercent.text = String(format: "Tip at %d%@", tip, "%");
        
            let split = Int(splitByStep.value);
            splitByNumber.text = String(split);
     
        var billAmountValue : Float = 0;
        if (inputTextField.text != ""){
            billAmountValue = NSDecimalNumber(string:inputTextField.text).floatValue/100.0
        }

        billAmount.text =  formatAsCurrency(NSNumber(value: billAmountValue));

    
        //recalculate the amount
        let tipPercentage = Float(Int(tipStep.value)) / 100.0;
        let taxPercentage = Float(Int(taxStep.value)) / 100.0;
        
        let tipAmount = billAmountValue * tipPercentage;
        let taxAmount = billAmountValue * taxPercentage;
        
        let sum = billAmountValue + tipAmount + taxAmount;
        
        let splitByNumberValue = Int(splitByStep.value);
        
        let perPersonAmount = sum / Float(splitByNumberValue);
        
        //update ui with new amount
        self.tipAmount.text =  formatAsCurrency(NSNumber(value: tipAmount))
        self.taxAmount.text = formatAsCurrency(NSNumber(value: taxAmount))
        totalAmount.text = formatAsCurrency(NSNumber(value: sum))
        self.perPersonAmount.text = formatAsCurrency(NSNumber(value: perPersonAmount))
        
    }
}

