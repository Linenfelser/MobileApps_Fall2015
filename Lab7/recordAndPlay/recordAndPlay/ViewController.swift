//
//  ViewController.swift
//  recordAndPlay
//
//  Created by Andrew Linenfelser on 10/15/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    let fileName = "audio.caf"
    
    
    override func viewDidLoad() {
        //disable buttons since no audio recorded
        playButton.enabled = false
        stopButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = dirPath[0] as! String //documents directory
        let audioFilePath = docDir.stringByAppendingPathComponent(fileName)
        let audioFileURL = NSURL(fileURLWithPath: audioFilePath)
        
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue, AVEncoderBitRateKey: 16, AVNumberOfChannelsKey: 2, AVSampleRateKey: 44100.0]
        var error : NSError?
        
        //create the AVAudioREcorder instance
        audioRecorder = AVAudioRecorder(URL: audioFileURL, settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        //test for error
        if let err = error{
            println("AVAudioRecorder error: \(err.localizedDescription)")
        }else{ //no error
            audioRecorder?.delegate = self // sets the delegate
            audioRecorder?.prepareToRecord() //ready to record
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func recordAudio(sender: AnyObject) {
        if audioRecorder?.recording == false{
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        //if not recording play audio file
        if audioRecorder?.recording == false{
            stopButton.enabled = true
            recordButton.enabled = false
            var error: NSError?
            
            //create the AVAudioPlayer instance
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url, error: &error)
            
            //test for error
            if let err = error{
                println("AVAudionPlayer error: \(err.localizedDescription)")
            }else{
                audioPlayer?.delegate = self
                audioPlayer?.play() //play the audio
            }
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
        //stop recording or playing
        if audioRecorder?.recording == true{
            audioRecorder?.stop()
        }else{
            audioPlayer?.stop()
        }
    }
    
    //AVAudioPlayerDelegateMethod
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        stopButton.enabled = false
    }

}

