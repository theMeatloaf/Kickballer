//
//  PlayerPickerViewController.swift
//  Kickballer
//
//  Created by Ryan Wedig on 8/22/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation
import UIKit

class PlayerPickerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var genderSelector: UISegmentedControl!
    var thisGame : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genderSelector.selectedSegmentIndex == 0 {
            return boysThatArentPlaying().count
        } else {
            return girlsThatArentPlaying().count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisPlayer : Player
        if genderSelector.selectedSegmentIndex == 0 {
            thisPlayer = boysThatArentPlaying()[indexPath.row]
        }else {
            thisPlayer = girlsThatArentPlaying()[indexPath.row]
        }
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "celly")
        cell.textLabel?.text = thisPlayer.name
        
        return cell
    }

    func boysThatArentPlaying() -> [Player] {
        let allBoys = Player.allBoys
        let boysInGame = thisGame!.boys
        return allBoys.filter{ (boy:Player) -> Bool in
            if !boysInGame.contains( {$0.name == boy.name} ) {
               return true
            } else {
                return false
            }
        }
    }
    
    func girlsThatArentPlaying() -> [Player] {
        let allGirls = Player.allGirls
        let girlsInGame = thisGame!.girls
        return allGirls.filter{ (girl:Player) -> Bool in
            if !girlsInGame.contains( {$0.name == girl.name} ) {
                return true
            } else {
                return false
            }
        }
    }
    
    
    @IBAction func swapGender(sender: AnyObject) {
        
    }
}