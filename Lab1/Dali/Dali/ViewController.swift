//
//  ViewController.swift
//  Dali
//
//  Created by Andrew Linenfelser on 9/1/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var artImage: UIImageView!
    //connect both of the buttons to this one method because the buttons are doing the same thing
    //the name of the button in the method is sender (an object of type UIButton
    //IBAction connects to the Interface Builder
    @IBAction func chooseArt(sender: UIButton) {
        if sender.tag == 1{
            artImage.image=UIImage(named: "Image2.jpg")
            messageText.text = "Space Elephants"
        }
        else if sender.tag == 2{
            artImage.image=UIImage(named: "Image3.jpg")
            messageText.text = "Thumb Forest"
        }
        else if sender.tag == 3{
            artImage.image=UIImage(named: "image4.jpg")
            messageText.text = "Pencil Art"
        }
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

