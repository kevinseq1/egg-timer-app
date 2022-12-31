//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = [
        "Soft": 3,
        "Medium": 420,
        "Hard": 720
    ]
    
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Each time the button is pressed invalidate the timer
        timer.invalidate()
        
        // Get the title of the button pressed
        let hardness = sender.currentTitle!
        
        // Get the total boil time for each type of egg
        totalTime = eggTimes[hardness]!
        
        // Resetting all the values
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // Create a timer and call the updateTimer() function
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        
        // Check how many seconds have passed
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            
            // Change the text once the timer is complete
            titleLabel.text = "DONE!"
            
            // Play a sound once the timer is complete
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
        
    }
    

}
