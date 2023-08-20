//
//  File.swift
//  EggTimer
//
//  Created by Михаил Кузнецов on 21.08.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft":300,"Medium":420,"Hard":720]
    var secondsRemaining = 60
    var timer = Timer ()
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    
   
   
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        
        timer.invalidate()
        progressBar.progress = 0
        titleLable.text = hardness
        secondsRemaining = eggTimes [hardness]!
        
        func playSound() {
            guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: path)

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
       timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
           if self.self.secondsPassed  <= self.eggTimes[hardness]! {
               let onePercents = Float(self.secondsPassed) / Float(self.eggTimes[hardness]!)
                self.secondsPassed += 1
                self.progressBar.progress = Float(onePercents)
                
            }
           
           else {
                Timer.invalidate()
               self.titleLable.text = "DONE"
               playSound()
            }
            
        }
        
    }
}
   
    

