 //
//  Game.swift
//  oopexercise
//
//  Created by Tim Knight on 06/02/2016.
//  Copyright © 2016 Tim Knight. All rights reserved.
//

import Foundation

class Game {
    
    private var _playerOne: Player! = Player(name: "Troll", hp: 25, attackPwr: 10)
    private var _playerTwo: Player! = Player(name: "Spartan", hp: 20, attackPwr: 15)
    
    var playerOne: Player {        
        get {
           return _playerOne
        }
    }
    
    var playerTwo: Player {
        get {
            return _playerTwo
        }
    }
    
    convenience init(playerOne: Player, playerTwo: Player) {
        print(playerOne)
        self.init(playerOne: playerOne, playerTwo: playerTwo)
    }
}