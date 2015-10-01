//
//  ViewController.swift
//  tipCalculator
//
//  Created by Andrew Linenfelser on 9/17/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var checkAmount: UITextField!
    @IBOutlet weak var tipP: UITextField!
    @IBOutlet weak var numPeople: UITextField!
    
    @IBOutlet weak var tipDue: UILabel!
    @IBOutlet weak var totalDue: UILabel!
    @IBOutlet weak var totalDuePP: UILabel!
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func updateTipTotals(){
        let amount = (checkAmount.text as NSString).floatValue
        let pct = (tipP.text as NSString).floatValue/100
        let numberOfPeople = numPeople.text.toInt()//returns an optional
        let tip = amount*pct
        let total = amount+tip
        var personTotal : Float = 0.0
        if numberOfPeople != nil{
            if numberOfPeople! > 0{
                personTotal = total / Float(numberOfPeople!)
            }
            else{
                //create a UIAlertController object
                let alert = UIAlertController(title: "WARNING", message: "The number of people must be greate than 0", preferredStyle: UIAlertControllerStyle.Alert)
        
            }
        }
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        tipDue.text = currencyFormatter.stringFromNumber(tip)
        totalDue.text=currencyFormatter.stringFromNumber(total)
        totalDuePP.text=currencyFormatter.stringFromNumber(personTotal)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        updateTipTotals()
    }
    
    override func viewDidLoad() {
        checkAmount.delegate=self
        tipP.delegate=self
        numPeople.delegate=self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

