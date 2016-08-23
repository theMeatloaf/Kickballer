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
    
    static func getAllBoys() -> [Player] {
        if NSUserDefaults.standardUserDefaults().objectForKey("boysArray") != nil {
            let savedArray = NSUserDefaults.standardUserDefaults().objectForKey("boysArray")! as! [String]
            return savedArray.map({ (name:String) -> Player in
                let player = Player()
                player.name = name
                player.gender = .Male
                return player
            })
        } else {
            //put some stuff in there...
            self.addBoy(boy("Ryan"))
            return getAllBoys()
        }
    }
    
    static func getAllGirls() -> [Player] {
        if NSUserDefaults.standardUserDefaults().objectForKey("girlsArray") != nil {
            let savedArray = NSUserDefaults.standardUserDefaults().objectForKey("girlsArray")! as! [String]
            return savedArray.map({ (name:String) -> Player in
                let player = Player()
                player.name = name
                player.gender = .Female
                return player
            })
        } else {
            self.addGirl(girl("Jenny"))
            return getAllGirls()
        }
    }
    
    static func addBoy(player:Player) {
        var savedArray : NSMutableArray
        if NSUserDefaults.standardUserDefaults().objectForKey("boysArray") != nil {
            let array = NSUserDefaults.standardUserDefaults().objectForKey("boysArray")! as! NSArray
            savedArray = NSMutableArray(array: array)
        } else {
            savedArray = []
        }
        savedArray.insertObject(player.name, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(savedArray, forKey: "boysArray")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func addGirl(player:Player) {
        var savedArray : NSMutableArray
        if NSUserDefaults.standardUserDefaults().objectForKey("girlsArray") != nil {
            let array = NSUserDefaults.standardUserDefaults().objectForKey("girlsArray")! as! NSMutableArray
            savedArray = NSMutableArray(array: array)
        } else {
            savedArray = []
        }
        savedArray.insertObject(player.name, atIndex: 0)
        NSUserDefaults.standardUserDefaults().setObject(savedArray, forKey: "girlsArray")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
