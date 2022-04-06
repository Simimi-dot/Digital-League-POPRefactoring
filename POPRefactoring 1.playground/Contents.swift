import UIKit

enum AttackStyle: String {
    case melee = "melee attack!"
    case longRange = "long range attack!"
}

enum AllianceUltimate: String {
    case archmage = "melee atacks"
    case mountainKing = "mass teleport"
}

enum GuildType {
    case alliance
    case orc
}

protocol Actions {
    func attack(attackStyle: AttackStyle)
    func move()
    func stop()
}

extension Actions {
    func attack(attackStyle: AttackStyle) {
        if attackStyle == .melee {
            print("\(AttackStyle.melee.rawValue)")
        } else {
            print("\(AttackStyle.longRange.rawValue)")
        }
    }
    
    func move() {
        print("move")
    }
    
    func stop() {
        print("stop")
    }
}

protocol Statistics {
    var armor: Float? { get }
    var attackPower: Float? { get }
    var strenght: Float? { get }
    var agility: Float? { get }
    var intelligence: Float? { get }
    var hitPoints: Float? { get }
    var mana: Float? { get }
    
    func updateStatistics (_ statistics: Self)
}


class Alliance: Actions, Statistics {
    
    var armor: Float?
    var attackPower: Float?
    var strenght: Float?
    var agility: Float?
    var intelligence: Float?
    var hitPoints: Float?
    var mana: Float?
    
    init(armor: Float, attackPower: Float, strenght: Float, agility: Float, intelligence: Float, hitPoints: Float, mana: Float) {
        self.armor = armor
        self.attackPower = attackPower
        self.strenght = strenght
        self.agility = agility
        self.intelligence = intelligence
        self.hitPoints = hitPoints
        self.mana = mana
    }
    
    
    func updateStatistics(_ statistics: Alliance) {
        self.armor = statistics.armor
        self.attackPower = statistics.attackPower
        self.strenght = statistics.strenght
        self.agility = statistics.agility
        self.intelligence = statistics.intelligence
        self.hitPoints = statistics.hitPoints
        self.mana = statistics.mana
    }
    
    func ultimate(_ ult: AllianceUltimate) {
        
    }
}

class Archmage: Alliance {
    override func ultimate(_ ult: AllianceUltimate) {
        guard ult == .archmage else {
            return
        }
        
        print("\(ult.rawValue)")
    }
}

class MountainKing: Alliance {
    override func ultimate(_ ult: AllianceUltimate) {
        guard ult == .mountainKing else {
            return
        }
        
        print("\(ult.rawValue)")
    }
}
