//
//  ViewController.swift
//  hack1
//
//  Created by Jasica Wong on 5/3/18.
//  Copyright © 2018 Jasica Wong. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var startButtonHide: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var gameoverLabel: UILabel!
    
    @IBAction func tryAgain(_ sender: UIButton) {
        self.score = 0
        self.gameoverLabel.isHidden = true
        startButton(UIButton())
    }

    @IBAction func startButton(_ sender: UIButton) {
//        helloWorldTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(arrow), userInfo: nil, repeats: true)
        arrow()
        motion()
    }
    func delay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.game()
        })
    }
    func gameover(){
        helloWorldTimer.invalidate()
        DispatchQueue.main.async {
            self.tryAgainButton.isHidden = false
            self.scoreLabel.textColor = UIColor.red
            self.scoreLabel.text = "Score: \(self.score)"
            self.gameoverLabel.isHidden = false
            self.gameoverLabel.textColor = UIColor.red
        }
        motionManager.stopDeviceMotionUpdates()
    }
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    
    var helloWorldTimer = Timer()
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    var rand = 0
    var color = 0
    var score = 0
    var move = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameoverLabel.isHidden = true
        scoreLabel.isHidden = true
        tryAgainButton.isHidden = true
        if motionManager.isDeviceMotionAvailable {
            print("We can detect device motion")
        }
        else {
            print("We cannot detect device motion")
        }
    }
    
    @objc func arrow(){
        self.rand = Int(arc4random_uniform(UInt32(4)))
        self.color = Int(arc4random_uniform(UInt32(2)))
        self.upLabel.isHidden = true
        rightLabel.isHidden = true
        downLabel.isHidden = true
        leftLabel.isHidden = true
        scoreLabel.isHidden = false
        scoreLabel.textColor = UIColor.green
        startButtonHide.isHidden = true
        tryAgainButton.isHidden = true

        if self.rand == 0 && self.color == 0{
            self.upLabel.isHidden = false
            self.upLabel.textColor = UIColor.green
                self.delay()
        }
        else if self.rand == 0 && self.color == 1{
            self.upLabel.isHidden = false
            self.upLabel.textColor = UIColor.red
                self.delay()
        }
        else if self.rand == 1 && self.color == 0{
            self.rightLabel.isHidden = false
            self.rightLabel.textColor = UIColor.green
                self.delay()
        }
        else if self.rand == 1 && self.color == 1{
            self.rightLabel.isHidden = false
            self.rightLabel.textColor = UIColor.red
                self.delay()
        }
        else if self.rand == 2 && self.color == 0{
            self.downLabel.isHidden = false
            self.downLabel.textColor = UIColor.green
                self.delay()
        }
        else if self.rand == 2 && self.color == 1{
            self.downLabel.isHidden = false
            self.downLabel.textColor = UIColor.red
                self.delay()
        }
        else if self.rand == 3 && self.color == 0{
            self.leftLabel.isHidden = false
            self.self.leftLabel.textColor = UIColor.green
                self.delay()
        }
        else if self.rand == 3 && self.color == 1{
            self.leftLabel.isHidden = false
            self.leftLabel.textColor = UIColor.red
                self.delay()
        }
        self.scoreLabel.text = String(self.score)
    }
    
    func motion(){
        motionManager.deviceMotionUpdateInterval = 0.5
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            if let mydata = data {
                let roll = self.degrees(mydata.attitude.roll)
                let pitch = self.degrees(mydata.attitude.pitch)
                print(pitch, roll, self.move)
                if pitch < -35{
                    self.move = 1
                }
                else if pitch > 25{
                    self.move = 3
                }
                else if roll > 25{
                    self.move = 2
                }
                else if roll < -25{
                    self.move = 4
                }
                else if pitch > 25{
                    self.move = 3
                }
                else if pitch < -25{
                    self.move = 1
                }
                else if roll < -25{
                    self.move = 4
                }
                else if roll > 25{
                    self.move = 2
                }
            }
        }
    }
    
    func game(){
        if self.rand == 0 && self.color == 0{
            if self.move == 1{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 0 && self.color == 1{
            if self.move == 3{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 1 && self.color == 0{
            if self.move == 2{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 1 && self.color == 1{
            if self.move == 4{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 2 && self.color == 0{
            if self.move == 3{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 2 && self.color == 1{
            if self.move == 1{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 3 && self.color == 0{
            if self.move == 4{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
        else if self.rand == 3 && self.color == 1{
            if self.move == 2{
                score += 1
                self.arrow()
            }
            else{
                self.gameover()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }
        }


