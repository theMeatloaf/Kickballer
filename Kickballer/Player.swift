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
    
    static func boy(_ name:String) -> Player {
        let boy = Player()
        boy.gender = .Male
        boy.name = name
        return boy
    }
    
    static func girl(_ name:String) -> Player {
        let girl = Player()
        girl.gender = .Female
        girl.name = name
        return girl
    }
    
    static func getAllBoys() -> [Player] {
        if let savedArray = UserDefaults.standard.object(forKey: "boysArray") as? [String] {
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
        if let savedArray = UserDefaults.standard.object(forKey: "girlsArray") as? [String] {
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
    
    static func addBoy(_ player:Player) {
        var savedArray : NSMutableArray
        if let array = UserDefaults.standard.object(forKey: "boysArray") as? NSArray {
            savedArray = NSMutableArray(array: array)
        } else {
            savedArray = []
        }
        savedArray.add(player.name)
        UserDefaults.standard.set(savedArray, forKey: "boysArray")
        UserDefaults.standard.synchronize()
    }
    
    static func addGirl(_ player:Player) {
        var savedArray : NSMutableArray
        if let array = UserDefaults.standard.object(forKey: "girlsArray") as? NSArray {
            savedArray = NSMutableArray(array: array)
        } else {
            savedArray = []
        }
        savedArray.add(player.name)
        UserDefaults.standard.set(savedArray, forKey: "girlsArray")
        UserDefaults.standard.synchronize()
    }
    
    static func deleteGirl(_ player:Player) {
        var savedArray : NSMutableArray
        if let array = UserDefaults.standard.object(forKey: "girlsArray") as? NSArray {
            savedArray = NSMutableArray(array: array)
        } else {
            savedArray = []
        }
        savedArray.remove(player.name)
        UserDefaults.standard.set(savedArray, forKey: "girlsArray")
        UserDefaults.standard.synchronize()
    }
    
    static func deleteBoy(_ player:Player) {
        var savedArray : NSMutableArray
        if let array = UserDefaults.standard.object(forKey: "boysArray") as? NSArray {
            savedArray = NSMutableArray(array: array)
        } else {
            savedArray = []
        }
        savedArray.remove(player.name)
        UserDefaults.standard.set(savedArray, forKey: "boysArray")
        UserDefaults.standard.synchronize()
    }
}
