//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Emil on 26/02/16.
//  Copyright © 2016 Emil. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController, AVAudioPlayerDelegate {
   
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var receiveAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    @IBOutlet weak var stopButton: UIButton!
    
    //var player:AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        
        // Do any additional setup after loading the view.
        stopButton.hidden = true
        let soundURL: NSURL
        
        if let sound = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            
            soundURL = NSURL(fileURLWithPath: sound)
            print("received file", receiveAudio.filePathUrl)
            do {
                // audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL)
                // play the data received due to segue
                audioPlayer = try AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl)
                audioPlayer.prepareToPlay()
                audioPlayer.delegate = self
                audioFile = try! AVAudioFile(forReading: receiveAudio.filePathUrl)
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
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.hidden = false
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = 1000
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
        
    }
    
    @IBAction func stopPlayingSound(sender: UIButton) {
        audioPlayer.stop()
        stopButton.hidden = true
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if (flag) {
            print("successfully finished playing")
            stopButton.hidden = true
        } else {
            print("Didn not finish plaing")
        }
    }
}
