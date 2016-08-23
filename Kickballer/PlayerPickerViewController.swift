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
    var selectedBoys : Set<NSIndexPath> = Set([])
    var selectedGirls : Set<NSIndexPath> = Set([])
    
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
        let allBoys = Player.getAllBoys()
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
        let allGirls = Player.getAllGirls()
        let girlsInGame = thisGame!.girls
        return allGirls.filter{ (girl:Player) -> Bool in
            if !girlsInGame.contains( {$0.name == girl.name} ) {
                return true
            } else {
                return false
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if genderSelector.selectedSegmentIndex == 0 {
            //add boy
            self.selectedBoys.insert(indexPath)
        } else {
            self.selectedGirls.insert(indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if genderSelector.selectedSegmentIndex == 0 {
            //remove boy
            self.selectedBoys.remove(indexPath)
        } else {
            self.selectedGirls.remove(indexPath)
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        //go through each selected array and add to game
        let allBoys = self.boysThatArentPlaying()
        for index in self.selectedBoys {
            print("\(index.row)")
            let boy = allBoys[index.row]
            self.thisGame?.boys.insert(boy, atIndex: 0)
        }
        
        let allGirls = self.girlsThatArentPlaying()
        for index in self.selectedGirls {
            let girl = allGirls[index.row]
            self.thisGame?.girls.insert(girl, atIndex: 0)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func newPlayer(sender: AnyObject) {
        //create the form for the new player
        let newPlayer = Player()
        
        let alert = UIAlertController(title: "New Player", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Player Name"
        }
        
        let saveMaleAction = UIAlertAction(title: "Male", style: .Default) { (action:UIAlertAction) in
            let name = alert.textFields?.first?.text
            newPlayer.name = name!
            newPlayer.gender = .Male
            Player.addBoy(newPlayer)
            self.tableView.reloadData()
        }
        
        let saveFemaleAction = UIAlertAction(title: "Female", style: .Default) { (action) in
            let name = alert.textFields?.first?.text
            newPlayer.name = name!
            newPlayer.gender = .Female
            Player.addGirl(newPlayer)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(saveMaleAction)
        alert.addAction(saveFemaleAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //reselect
    @IBAction func swapGender(sender: AnyObject) {
        self.tableView.reloadData()
        if genderSelector.selectedSegmentIndex == 0 {
            for index in self.selectedBoys {
                self.tableView.selectRowAtIndexPath(index, animated: false, scrollPosition: .None)
            }
        } else {
            for index in self.selectedGirls {
                self.tableView.selectRowAtIndexPath(index, animated: false, scrollPosition: .None)
            }
        }
    }
}