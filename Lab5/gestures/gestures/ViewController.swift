//
//  ViewController.swift
//  gestures
//
//  Created by Andrew Linenfelser on 10/13/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var audioPlayer = AVAudioPlayer?()
    
    @IBAction func handleLongPress(sender: UILongPressGestureRecognizer) {
        let sound1 = "RickSound"
        let sound2 = "RickSound2"
        var temp = 0
        if temp == 0{
            let audioFilePath = NSBundle.mainBundle().pathForResource(sound2, ofType: "mp3")
            let fileURL = NSURL(fileURLWithPath: audioFilePath!)
            audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            if audioPlayer != nil{
                audioPlayer!.play()
            }
            
            temp = 1
            if temp == 1{
                let audioFilePath = NSBundle.mainBundle().pathForResource(sound2, ofType: "mp3")
                let fileURL = NSURL(fileURLWithPath: audioFilePath!)
                audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
                if audioPlayer != nil{
                    audioPlayer!.play()
                }
               temp = 0
            }
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true //allow multiple gestures
    }
    
    @IBAction func handleRotate(sender: UIRotationGestureRecognizer) {
        sender.view!.transform = CGAffineTransformRotate(sender.view!.transform, sender.rotation)
        sender.rotation = 0
        
    }
    @IBAction func handlePinch(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale=1 //reset scale
    }
    
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view) //returns the new location
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: view) //set translation back to zero
        
        //figure out when touch ends and how fast the touch was going for deceleration
        //sender is pand gesture recognizer
        
        if sender.state == UIGestureRecognizerState.Ended{
            //figure out the velocity
            let velocity = sender.velocityInView(self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            
            //if the length is < 200, then decrease the base speed. otherwise increase it
            let slideFactor = 0.1 * slideMultiplier //increase for a greater slide
            //calculate a final point based on the velocity and the slide factor
            var finalPoint = CGPoint(x: sender.view!.center.x + (velocity.x * slideFactor), y:sender.view!.center.y + (velocity.y * slideFactor))
            //make sure the final pount is within the view's bounds
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            //animate the view
            UIView.animateWithDuration(Double(slideFactor * 2), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {sender.view!.center = finalPoint}, completion: nil)
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

