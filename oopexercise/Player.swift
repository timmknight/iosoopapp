//
//  Player.swift
//  oopexercise
//
//  Created by Tim Knight on 06/02/2016.
//  Copyright © 2016 Tim Knight. All rights reserved.
//

import Foundation
class Player : Character {

    private var _name:String = "Player"
    
    var name: String {
        get {
            return _name
        }
    }
    
    convenience init(name: String, hp: Int, attackPwr: Int) {
        self.init(startingHp: hp, attackPwr: attackPwr)
        self._name = name
    }
}