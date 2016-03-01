//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Emil on 26/02/16.
//  Copyright © 2016 Emil. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
   
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var stopButton: UIButton!
    
    //var player:AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stopButton.hidden = true
        let soundURL: NSURL
        
        if let sound = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            soundURL = NSURL(fileURLWithPath: sound)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL)
                audioPlayer.prepareToPlay()
                
            } catch {
                print("error fetching the file")
            }
            
        } else {
            print("the file is not found")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playSlowAction(sender: UIButton) {
        print("play slow pressed")
        
        // 1. Play a downloaded file from the project.
        stopButton.hidden = false
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = 0.5
        audioPlayer.volume = 1.0
        audioPlayer.play()

        /*
        // 2. Locally store the contents of the url into a variable and
        // then play from there.
        do {
            let url = "https://s3.amazonaws.com/udacity-hosted-downloads/ud585/audio/movie_quote.mp3"
            let fileURL = NSURL(string: url)
            
            let soundData = NSData(contentsOfURL: fileURL!)
            audioPlayer = try AVAudioPlayer(data: soundData!)
            if (audioPlayer.prepareToPlay()) {
            
                audioPlayer.volume = 1.0
                audioPlayer.rate = 1.0
                audioPlayer.play()
            } else {
                print("failed at prepare to play")
            }
        } catch {
            print("Error getting the audio file")
        }
        */
        
        /*
        // 3. Streaming directly from the internet using the url
        let url = "https://s3.amazonaws.com/udacity-hosted-downloads/ud585/audio/movie_quote.mp3"
        let fileURL = NSURL(string: url)
        
        player = AVPlayer(URL: fileURL!)
        player.volume = 1.0
        player.rate = 1.0
        player.play()
        */
    }
    
    @IBAction func playFast(sender: UIButton) {
        
        stopButton.hidden = false
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = 1.5
        audioPlayer.volume = 1.0
        audioPlayer.play()
    }
    
    @IBAction func stopPlayingSound(sender: UIButton) {
        audioPlayer.stop()
        stopButton.hidden = true
    }
}
