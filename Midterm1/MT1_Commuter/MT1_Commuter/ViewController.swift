//
//  ViewController.swift
//  MT1_Commuter
//
//  Created by Andrew Linenfelser on 10/29/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var commuteMilesField: UITextField!
    @IBOutlet weak var totalCommuteTimeLabel: UILabel!
    @IBOutlet weak var transSegControl: UISegmentedControl!
    
    @IBOutlet weak var transPic: UIImageView!
    @IBOutlet weak var gasToPurchaseLabel: UILabel!
    
    @IBOutlet weak var monthSwitch: UISwitch!
    
    func textFieldShouldReturn(textField: UITextField) ->Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        changeTransportation()
    }
    
    
//    func monthlyCommute(){
//        if monthSwitch.on{
//            totalCommuteTimeLabel
//        }
//    }
    
    func changeTransportation(){
        
        
        if transSegControl.selectedSegmentIndex == 0{
            
            var alert = UIAlertController(title: "CARPOOL!", message: "you should probably carpool", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            updateCarInfo()
        }
            
        else if transSegControl.selectedSegmentIndex == 1{
            updateBusInfo()
        }
        else if transSegControl.selectedSegmentIndex == 2{
            updateBikeInfo()
        }
    }
    
    
    
    @IBAction func commuteButton(sender: UIButton) {
        changeTransportation()
    }
    
    
    func updateCarInfo(){
        let miles = (commuteMilesField.text as NSString).floatValue
        let tt = (miles/20)
        let totalTime = tt * 60
        
        let gallons = miles/24
        
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if monthSwitch.on{
            totalCommuteTimeLabel.text = numberFormatter.stringFromNumber(totalTime*20)! + " mins"
            transPic.image = UIImage(named: "Car")
            gasToPurchaseLabel.text = numberFormatter.stringFromNumber(gallons*20)! + " gallons"
        }
        else{
            
            totalCommuteTimeLabel.text = numberFormatter.stringFromNumber(totalTime)! + " mins"
            transPic.image = UIImage(named: "Car")
            gasToPurchaseLabel.text = numberFormatter.stringFromNumber(gallons)! + " gallons"
        }
        
        
    }
    
    func updateBusInfo(){
        let miles = (commuteMilesField.text as NSString).floatValue
        let tt = (miles/10)
        let totalTime = tt * 60

        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if monthSwitch.on{
            totalCommuteTimeLabel.text = numberFormatter.stringFromNumber(totalTime*20)! + " mins"
            transPic.image = UIImage(named: "Bus")
            gasToPurchaseLabel.text = numberFormatter.stringFromNumber(0)! + " gallons"
        }
        else{
            totalCommuteTimeLabel.text = numberFormatter.stringFromNumber(totalTime)! + " mins"
            transPic.image = UIImage(named: "Bus")
            gasToPurchaseLabel.text = numberFormatter.stringFromNumber(0)! + " gallons"
        }
        
    }
    func updateBikeInfo(){
        let miles = (commuteMilesField.text as NSString).floatValue
        let tt = (miles/12)
        let totalTime = tt * 60 + 10 //5 minutes each way
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if monthSwitch.on{
            totalCommuteTimeLabel.text = numberFormatter.stringFromNumber(totalTime)! + " mins"
            transPic.image = UIImage(named: "Bike")
            gasToPurchaseLabel.text = numberFormatter.stringFromNumber(0)! + " gallons"
        }
        else{
            totalCommuteTimeLabel.text = numberFormatter.stringFromNumber(totalTime*20)! + " mins"
            transPic.image = UIImage(named: "Bike")
            gasToPurchaseLabel.text = numberFormatter.stringFromNumber(0)! + " gallons"
        }
    }

    
    override func viewDidLoad() {
        
        commuteMilesField.delegate=self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

