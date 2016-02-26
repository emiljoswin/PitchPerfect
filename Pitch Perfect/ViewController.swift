//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Emil on 22/02/16.
//  Copyright © 2016 Emil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record the user's voice
        recordingInProgress.hidden = false
    }

    @IBAction func stopRecording(sender: UIButton) {
        //TODO: stop recording when pressed.
        print("stop recording");
        recordingInProgress.hidden = true
    }
}

