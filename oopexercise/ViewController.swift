//
//  ViewController.swift
//  oopexercise
//
//  Created by Tim Knight on 05/02/2016.
//  Copyright © 2016 Tim Knight. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
//    ************** Outlets ***************
//    General
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var restartGameBtn: UIButton!
//    Player one
    @IBOutlet weak var playerOneAttackBtn: UIButton!
    @IBOutlet weak var playerOneAttackLbl: UILabel!
    @IBOutlet weak var playerOneImg: UIImageView!
    @IBOutlet weak var playerOneHpLbl: UILabel!
//    PLayer Two
    @IBOutlet weak var playerTwoAttackBtn: UIButton!
    @IBOutlet weak var playerTwoAttackLbl: UILabel!
    @IBOutlet weak var playerTwoImg: UIImageView!
    @IBOutlet weak var playerTwoHpLbl: UILabel!
    
//    ************** Variables ***************
    var game: Game!
    var playerOne: Player!
    var playerTwo: Player!
    
    var atkSound: AVAudioPlayer!
    var dieSound: AVAudioPlayer!
    
//    ************** OnLoad ***************
    override func viewDidLoad() {
        super.viewDidLoad()
//        Attack Sound
        let atkPath = NSBundle.mainBundle().pathForResource("atk", ofType: "wav")
        
        let atkSoundUrl = NSURL(fileURLWithPath: atkPath!)
        
        do {
            try atkSound = AVAudioPlayer(contentsOfURL: atkSoundUrl)
            atkSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
//        Death Sound
        let diePath = NSBundle.mainBundle().pathForResource("die", ofType: "wav")
        
        let dieSoundUrl = NSURL(fileURLWithPath: diePath!)
        
        do {
            try dieSound = AVAudioPlayer(contentsOfURL: dieSoundUrl)
            dieSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
//        Starts game
        newGame()
    }

//    ************** Actions ***************
//      Attack Actions
    @IBAction func playerOneAttack(sender: AnyObject) {

        playerAttack(playerOne, attackerAtkBtn: playerOneAttackBtn, victim: playerTwo, victimHpLbl: playerTwoHpLbl, victimImg: playerTwoImg, victimAttackBtn: playerTwoAttackBtn, victimAttackLbl: playerTwoAttackLbl)
        
        playerOneAttackBtn.enabled = false
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "enablePlayerOneButton", userInfo: nil, repeats: false)
    }


    @IBAction func playerTwoAttack(sender: AnyObject) {
        playerAttack(playerTwo, attackerAtkBtn: playerTwoAttackBtn, victim: playerOne, victimHpLbl: playerOneHpLbl, victimImg: playerOneImg, victimAttackBtn: playerOneAttackBtn, victimAttackLbl: playerOneAttackLbl)
        
        playerTwoAttackBtn.enabled = false
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "enablePlayerTwoButton", userInfo: nil, repeats: false)
    }
    
    
    func playerAttack(attacker: Player, attackerAtkBtn: UIButton, victim: Player, victimHpLbl: UILabel, victimImg: UIImageView, victimAttackBtn: UIButton, victimAttackLbl: UILabel) {
        playAtkSound()
        
        
        if attacker.isAlive {
            attacker.attack(attacker.attackPwr, target: victim)
            statusLbl.text = "\(attacker.name) attacks \(victim.name) for \(attacker.attackPwr)"
            victimHpLbl.text = "\(victim.hp) HP"
        }
        
        
        if !victim.isAlive {
            playDieSound()
            attackerAtkBtn.enabled = false
            victimImg.hidden = true
            victimAttackBtn.hidden = true
            victimAttackLbl.hidden = true
            victimHpLbl.hidden = true
            statusLbl.text = "\(attacker.name) wins!"
            restartGameBtn.hidden = false
        }
        
    }
    
//  Restart once someone dies
    @IBAction func restartGame(sender: AnyObject) {
        newGame()
        resetImgs()
    }
    
//    ************** Funcs ***************
    // Starts a new game
    func newGame() {
        game = Game()
        playerOne = game.playerOne
        playerTwo = game.playerTwo
        resetLbls()
    }
    
//  Enables attack buttons after an attack has happend - must be able to refactor
    func enablePlayerOneButton() {
        playerOneAttackBtn.enabled = true
    }
    
    func enablePlayerTwoButton() {
        playerTwoAttackBtn.enabled = true
    }
//  Reset images & labels  
    func resetImgs() {
        let turnFalse = [playerOneImg, playerTwoImg, playerOneAttackBtn, playerTwoAttackBtn, playerOneHpLbl, playerTwoHpLbl, playerOneAttackLbl, playerTwoAttackLbl]
        
        let turnTrue = [playerOneAttackBtn, playerTwoAttackBtn]
        
        for item in turnFalse {
            item.hidden = false
        }
        
        for item in turnTrue {
            item.enabled = true
        }
        
        restartGameBtn.hidden = true
    }
    
    func resetLbls() {
        statusLbl.text = "\(playerOne.name)  vs \(playerTwo.name)"
        playerOneHpLbl.text = "\(playerOne.hp) HP"
        playerTwoHpLbl.text = "\(playerTwo.hp) HP"
    }
    
//    Sound funcs
    func playAtkSound() {
        atkSound.play()
    }
    
    func playDieSound() {
        dieSound.play()
    }

}

