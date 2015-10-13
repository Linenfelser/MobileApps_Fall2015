//
//  ViewController.swift
//  rickAndMorty
//
//  Created by Andrew Linenfelser on 10/6/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var delta = CGPointMake(8, 5) //initalize the delta to move 12 pixels horizontally, 4 pixels vertically
    var shipRadius = CGFloat()
    var timer = NSTimer()
    var translation = CGPointMake(0.0, 0.0)
    var angle:CGFloat = 0.0
    

    @IBOutlet weak var imageRick: UIImageView!
    @IBOutlet weak var sliderOut: UISlider!
    @IBOutlet weak var intervalLabel: UILabel!
    

    @IBAction func slider(sender: UISlider) {
        timer.invalidate()
        changeSliderValue()
    }
    
    func moveImage(){
        let duration=Double(sliderOut.value)
        UIView.beginAnimations("imageRick", context: nil)
        UIView.animateWithDuration(duration, animations:
            {self.imageRick.transform=CGAffineTransformMakeScale(self.angle, self.angle)
                (self.imageRick.center = CGPointMake(self.imageRick.center.x + self.delta.x, self.imageRick.center.y + self.delta.y))})
            
        
            //self.translation.x += self.delta.x
            //self.translation.y += self.delta.y
    
        UIView.commitAnimations()
        angle += 0.01
        if angle > CGFloat(0.8*M_PI){
            angle=0
        }
        
        //imageRick.center=CGPointMake(imageRick.center.x + delta.x, imageRick.center.y + delta.y)
        
        if imageRick.center.x > self.view.bounds.size.width-shipRadius || imageRick.center.x < shipRadius{
            delta.x = -delta.x
        }
        if imageRick.center.y > self.view.bounds.size.height-shipRadius || imageRick.center.y + translation.y < shipRadius{
            delta.y = -delta.y
        }
        
    }
    
    @IBAction func changeSliderValue(){
        intervalLabel.text=String(format:"%.2f", sliderOut.value)
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(sliderOut.value), target: self, selector: "moveImage", userInfo: nil, repeats: true)
    }
    
    
    override func viewDidLoad() {
        
        shipRadius=imageRick.frame.size.width/2
        changeSliderValue()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

