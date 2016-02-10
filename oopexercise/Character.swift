//
//  Character.swift
//  oopexercise
//
//  Created by Tim Knight on 06/02/2016.
//  Copyright © 2016 Tim Knight. All rights reserved.
//

import Foundation
class Character {
    
    private var _hp: Int = 40
    private var _attackPwr: Int = 10

    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attackPwr: Int {
        get {
            return _attackPwr
        }
    }
    
    var isAlive: Bool {
        if hp <= 0 {
            return false
        } else {
            return true
        }
    }
    
    init(startingHp: Int, attackPwr: Int) {
        self._attackPwr = attackPwr
        self._hp = startingHp
    }
    
    func attack(attackPwr: Int, target: Player) -> Bool {
        target._hp -= attackPwr
        return true
    }
}