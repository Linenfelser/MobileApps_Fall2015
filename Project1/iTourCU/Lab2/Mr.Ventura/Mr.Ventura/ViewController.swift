//
//  ViewController.swift
//  Mr.Ventura
//
//  Created by Andrew Linenfelser on 9/13/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aceImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageControl: UISegmentedControl!
    @IBOutlet weak var acePic: UIImageView!
    @IBOutlet weak var capitalSwitch: UISwitch!
    
    
    @IBOutlet weak var fontSize: UILabel!
    
    
    func refreshUI(){
        imageLabel.text = "Mr.Ventura"
        imageControl.selectedSegmentIndex = -1
        capitalSwitch.on = false
        aceImage.image=UIImage(named: "ace1.png")
    }
    
    
    @IBAction func fontSize(sender: UISlider) {
        let fontS = sender.value
        fontSize.text = String(format: "%.0f", fontSize)
        let fontSizeCGFloat = CGFloat(fontS)
        imageLabel.font = UIFont.systemFontOfSize(fontSizeCGFloat)
    }
    
    @IBAction func changeCaps(sender: UISwitch) {
        caps()
    }
    
    func caps(){
        if capitalSwitch.on{
            imageLabel.text=imageLabel.text?.uppercaseString
        }
        else{
            imageLabel.text=imageLabel.text?.lowercaseString
        }
    }
    
        
    func changeImage(){
        if imageControl.selectedSegmentIndex == 0{
            acePic.image=UIImage(named: "ace2")
            imageLabel.text="Is there something in my teeth?"
        }
        else if imageControl.selectedSegmentIndex == 1{
            acePic.image=UIImage(named: "ace3")
            imageLabel.text="Put me in coach!"
        }
        else if imageControl.selectedSegmentIndex == 2{
            acePic.image=UIImage(named: "ace4")
            imageLabel.text="Allllllll righty then"
        }
    }
    
    @IBAction func changeInfo(sender: UISegmentedControl) {
        changeImage()
        caps()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

