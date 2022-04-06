import UIKit
import CoreGraphics


// MARK: - Enum

// Перечисление Гильдий
enum Guild {
    case alliance
    case orc
}

// Перечисление всех героев в игре
enum HeroesName: String {
    case archMage = "Archmage"
    case mountainKing = "Mountain King"
    case paladin = "Paladin"
    case bloodMage = "Blood Mage"
    case bladeMaster = "Blade master"
    case farSeer = "Far Seer"
    case taurenChieftain = "Tauren chieftain"
    case shadowHunter = "Shadow hunter"
}

// Перечисление стилей атаки
enum AttackStyle: String {
    case longRange = "Long range attack !"
    case mele = "Mele attack !"
}

// Перечислений ультимативных способностей героев альянса
enum Allultimates: String {
    case zeroUlti = "Нет ульты"
    case archMage = "Mass telepot"
    case mountainKing = "Avatar"
    case paladin = "Resurrection"
    case bloodmage = "Phoenix"
}

// MARK: - Protocol

// Протокол отвечающий за атаку
protocol Attacking {
    func atack()
}

// Протокол отвечающий за ультимативную способность
protocol UltimateAttack {
    var allianceHeroUlt: Allultimates { get }
    func ultimate()
}

// Протокол отвечающий за движения
protocol Actions {
    func move()
    func stop()
}

extension Actions {
    
    func move() {
        print("Move")
    }
    
    func stop() {
        print("Stop the hero")
    }
    
}

// Протокол отвечающий за статистику
protocol Stats {
    var statistics: Statistics { get }
    
    mutating func updateStatistics(_ stats: Self)
}

// Расширение для CGPoint отвечающий за передвижение героя и полет
extension CGPoint: CustomStringConvertible {
    
    public var description: String {
        return "Move to x: \(x), y: \(y)"
    }
    
    mutating func move(x: CGFloat? = nil, y: CGFloat? = nil) -> CGPoint {
        if let x = x {
            self.x += x
        }

        if let y = y {
            self.y += y
        }
        print(description)
        return self
    }

    mutating func forward(y: CGFloat) -> CGPoint {
        return move(x: nil, y: y)
    }

    mutating func backward(y: CGFloat) -> CGPoint {
        return move(x: nil, y: -y)
    }

    mutating func left(x: CGFloat) -> CGPoint {
        return move(x: -x, y: nil)
    }

    mutating func right(x: CGFloat) -> CGPoint {
        return move(x: x, y: nil)
    }
    
    mutating func flyTo(x: CGFloat, y: CGFloat) -> CGPoint {
        return move(x: x, y: y)
    }
    
}

//MARK: - Struct

struct Statistics {
    var name: HeroesName
    var armor: Float?
    var attackPower: Float?
    var strenght: Float?
    var agility: Float?
    var intelligence: Float?
    var hitpoints: Float?
    var mana: Float?
    var guild: Guild
    var attackStyle: AttackStyle
    var currentPosition: CGPoint
}

// MARK: - Hero

// Структура герой
struct Hero: Stats {
    var statistics: Statistics
    
    mutating func updateStatistics(_ stats: Hero) {
        self.statistics.armor = stats.statistics.armor
        self.statistics.attackPower = stats.statistics.attackPower
        self.statistics.strenght = stats.statistics.strenght
        self.statistics.agility = stats.statistics.agility
        self.statistics.intelligence = stats.statistics.intelligence
        self.statistics.hitpoints = stats.statistics.hitpoints
        self.statistics.mana = stats.statistics.mana
    }
}

// Расширение структуры героя для атаки
extension Hero: Attacking {
    
    func atack() {
        if statistics.attackStyle == .longRange {
            print("Происходит - \(statistics.attackStyle.rawValue)")
        } else {
            print("Осторожнее - \(statistics.attackStyle.rawValue)")
        }
    }
    
}

// Расширение структуры Hero которое отвечает за ульту
extension Hero: UltimateAttack {
    
    var allianceHeroUlt: Allultimates {
        var ultimate: Allultimates = .zeroUlti
        if statistics.guild == .alliance && statistics.name == .archMage {
            ultimate = .archMage
        } else if statistics.guild == .alliance && statistics.name == .mountainKing {
            ultimate = .mountainKing
        } else if statistics.guild == .alliance && statistics.name == .paladin {
            ultimate = .paladin
        } else if statistics.guild == .alliance && statistics.name == .bloodMage {
            ultimate = .bloodmage
        }
        return ultimate
        
    }
    
    func ultimate() {
        print("\(statistics.name.rawValue) использует ульту \(allianceHeroUlt.rawValue)")
    }
}

// Список всех героев в игре
var listOfHeroes = [
    Hero(statistics: .init(name: .archMage, armor: 3, attackPower: 27, strenght: 20, agility: 20, intelligence: 45, hitpoints: 350, mana: 500, guild: .alliance, attackStyle: .longRange, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .mountainKing, armor: 10, attackPower: 45, strenght: 45, agility: 25, intelligence: 10, hitpoints: 500, mana: 350, guild: .alliance, attackStyle: .mele, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .paladin, armor: 10, attackPower: 35, strenght: 40, agility: 15, intelligence: 20, hitpoints: 450, mana: 400, guild: .alliance, attackStyle: .mele, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .bloodMage, armor: 5, attackPower: 15, strenght: 25, agility: 15, intelligence: 50, hitpoints: 400, mana: 550, guild: .alliance, attackStyle: .longRange, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .bladeMaster, armor: 10, attackPower: 30, strenght: 35, agility: 40, intelligence: 15, hitpoints: 550, mana: 350, guild: .orc, attackStyle: .mele, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .farSeer, armor: 20, attackPower: 20, strenght: 40, agility: 20, intelligence: 15, hitpoints: 550, mana: 400, guild: .orc, attackStyle: .mele, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .taurenChieftain, armor: 30, attackPower: 40, strenght: 40, agility: 15, intelligence: 15, hitpoints: 750, mana: 400, guild: .orc, attackStyle: .mele, currentPosition: CGPoint(x: 0, y: 0))),
    
    Hero(statistics: .init(name: .shadowHunter, armor: 15, attackPower: 15, strenght: 20, agility: 15, intelligence: 40, hitpoints: 600, mana: 580, guild: .orc, attackStyle: .longRange, currentPosition: CGPoint(x: 0, y: 0)))
]

// Отсортированный список героев альянса по силе атаки
var listOfAlliance = listOfHeroes.filter { allianceHero in
    return allianceHero.statistics.guild == .alliance
}.sorted { firsthero, secondHero in
    guard let heroOne = firsthero.statistics.attackPower,
          let heroTwo = secondHero.statistics.attackPower else { return false }
    return heroOne > heroTwo
}

// Отсортированный список героев орды по силе атаки
var listOfOrc = listOfHeroes.filter { orcHero in
    return orcHero.statistics.guild == .orc
}.sorted { firstHero, secondHero in
    guard let heroOne = firstHero.statistics.attackPower,
            let heroTwo = secondHero.statistics.attackPower else { return false }
    return heroOne > heroTwo
}

listOfOrc[0].statistics.name
listOfOrc[0].atack()

listOfOrc[0].statistics.currentPosition.flyTo(x: -5, y: -5)
listOfOrc[0].statistics.currentPosition.forward(y: 5)

// MARK: - Dictionary

// Словарь для хранения передвижения героев Альянса
var dictionatyOfAllianceMovement: [String: CGPoint] = [
    "\(listOfAlliance[0].statistics.name.rawValue)": CGPoint(
        x: listOfAlliance[0].statistics.currentPosition.x,
        y: listOfAlliance[0].statistics.currentPosition.y),
    
    "\(listOfAlliance[1].statistics.name.rawValue)": CGPoint(
        x: listOfAlliance[1].statistics.currentPosition.x,
        y: listOfAlliance[1].statistics.currentPosition.y),
    
    "\(listOfAlliance[2].statistics.name.rawValue)": CGPoint(
        x: listOfAlliance[2].statistics.currentPosition.x,
        y: listOfAlliance[2].statistics.currentPosition.y),
    
    "\(listOfAlliance[3].statistics.name.rawValue)": CGPoint(
        x: listOfAlliance[3].statistics.currentPosition.x,
        y: listOfAlliance[3].statistics.currentPosition.y),
    
]

// Словарь для хранения передвижения героев Орды
var dictionaryOfOrcMovement: [String: CGPoint] = [
    "\(listOfOrc[0].statistics.name.rawValue)": CGPoint(
        x: listOfOrc[0].statistics.currentPosition.x,
        y: listOfOrc[0].statistics.currentPosition.y),
    
    "\(listOfOrc[1].statistics.name.rawValue)": CGPoint(
        x: listOfOrc[1].statistics.currentPosition.x,
        y: listOfOrc[1].statistics.currentPosition.y),
    
    "\(listOfOrc[2].statistics.name.rawValue)": CGPoint(
        x: listOfOrc[2].statistics.currentPosition.x,
        y: listOfOrc[2].statistics.currentPosition.y),
    
    "\(listOfOrc[3].statistics.name.rawValue)": CGPoint(
        x: listOfOrc[3].statistics.currentPosition.x,
        y: listOfOrc[3].statistics.currentPosition.y),
    
]

dictionatyOfAllianceMovement[listOfAlliance[0].statistics.name.rawValue] = listOfAlliance[0].statistics.currentPosition.forward(y: 5)

dictionatyOfAllianceMovement[listOfAlliance[1].statistics.name.rawValue] = listOfAlliance[1].statistics.currentPosition.flyTo(x: 10, y: 10)

dictionaryOfOrcMovement[listOfOrc[0].statistics.name.rawValue] = listOfOrc[0].statistics.currentPosition.flyTo(x: 15, y: 15)

dictionaryOfOrcMovement[listOfOrc[3].statistics.name.rawValue] = listOfOrc[3].statistics.currentPosition.backward(y: 25)



dictionatyOfAllianceMovement
dictionaryOfOrcMovement
