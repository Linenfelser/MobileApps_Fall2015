//
//  ViewController.swift
//  favorites
//
//  Created by Andrew Linenfelser on 10/20/15.
//  Copyright (c) 2015 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var user = Favorite()
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        //do this when coming back to the first view
        bookLabel.text=user.favBook
        authorLabel.text=user.favAuthor
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

