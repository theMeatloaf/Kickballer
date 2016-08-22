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
    
}