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
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.

        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        stopButton.hidden = true
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            audioFile = try! AVAudioFile(forReading: receiveAudio.filePathUrl)
        } catch {
            print("error fetching the file")
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
        
        playTheAudio(rate: 0.5)

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
        playTheAudio(rate: 1.5)
    }
    
    
    func playTheAudio(rate r: Float) {
        stopButton.hidden = false
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = r
        audioPlayer.volume = 1.0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playWithEngine(pitch: 1000, rate: 1.0)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playWithEngine(pitch: -1000, rate: 1.0)
    }
    
    func playWithEngine(pitch p: Float, rate: Float) {
        audioEngine.reset()
        stopButton.hidden = false
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = p
        audioEngine.attachNode(changePitchEffect)
        
        let playbackRateEffect = AVAudioUnitVarispeed()
        playbackRateEffect.rate = rate
        audioEngine.attachNode(playbackRateEffect)
        
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: playbackRateEffect, format: nil)
        audioEngine.connect(playbackRateEffect, to: audioEngine.outputNode, format: nil)
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
