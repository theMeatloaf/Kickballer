//
//  Player.swift
//  Kickballer
//
//  Created by Ryan Wedig on 8/22/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation

enum Gender : String{
    case Male = "Male"
    case Female = "Female"
}

class Player: NSObject {

    var name : String = ""
    var gender : Gender = .Male
    
    static func boy(name:String) -> Player {
        let boy = Player()
        boy.gender = .Male
        boy.name = name
        return boy
    }
    
    static func girl(name:String) -> Player {
        let girl = Player()
        girl.gender = .Female
        girl.name = name
        return girl
    }
    
    static var allBoys : [Player] {
        return [boy("Brad"),boy("Sean"),boy("Ryan")]
    }
    
    static var allGirls : [Player] {
        return [girl("Stacy"),girl("Rion"),girl("Jenny")]
    }
}
