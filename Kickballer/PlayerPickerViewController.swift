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
    var selectedBoys : Set<IndexPath> = Set([])
    var selectedGirls : Set<IndexPath> = Set([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genderSelector.selectedSegmentIndex == 0 {
            return boysThatArentPlaying().count
        } else {
            return girlsThatArentPlaying().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let thisPlayer : Player
        if genderSelector.selectedSegmentIndex == 0 {
            thisPlayer = boysThatArentPlaying()[indexPath.row]
        }else {
            thisPlayer = girlsThatArentPlaying()[indexPath.row]
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "celly")
        cell.textLabel?.text = thisPlayer.name
        
        return cell
    }

    func boysThatArentPlaying() -> [Player] {
        let allBoys = Player.getAllBoys()
        let boysInGame = thisGame!.boys
        return allBoys.filter{ (boy:Player) -> Bool in
            if !boysInGame.contains( where: {$0.name == boy.name} ) {
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
            if !girlsInGame.contains( where: {$0.name == girl.name} ) {
                return true
            } else {
                return false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if genderSelector.selectedSegmentIndex == 0 {
            //add boy
            self.selectedBoys.insert(indexPath)
        } else {
            self.selectedGirls.insert(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if genderSelector.selectedSegmentIndex == 0 {
            //remove boy
            self.selectedBoys.remove(indexPath)
        } else {
            self.selectedGirls.remove(indexPath)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        //go through each selected array and add to game
        let allBoys = self.boysThatArentPlaying()
        for index in self.selectedBoys {
            print("\(index.row)")
            let boy = allBoys[index.row]
            self.thisGame?.boys.append(boy)
        }
        
        let allGirls = self.girlsThatArentPlaying()
        for index in self.selectedGirls {
            let girl = allGirls[index.row]
            self.thisGame?.girls.append(girl)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newPlayer(_ sender: AnyObject) {
        //create the form for the new player
        let newPlayer = Player()
        
        let alert = UIAlertController(title: "New Player", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Player Name"
        }
        
        let saveMaleAction = UIAlertAction(title: "Male", style: .default) { (action:UIAlertAction) in
            let name = alert.textFields?.first?.text
            newPlayer.name = name!
            newPlayer.gender = .Male
            Player.addBoy(newPlayer)
            self.tableView.reloadData()
            self.swapGender(self)
        }
        
        let saveFemaleAction = UIAlertAction(title: "Female", style: .default) { (action) in
            let name = alert.textFields?.first?.text
            newPlayer.name = name!
            newPlayer.gender = .Female
            Player.addGirl(newPlayer)
            self.tableView.reloadData()
            self.swapGender(self)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(saveMaleAction)
        alert.addAction(saveFemaleAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //reselect
    @IBAction func swapGender(_ sender: AnyObject) {
        self.tableView.reloadData()
        if genderSelector.selectedSegmentIndex == 0 {
            for index in self.selectedBoys {
                self.tableView.selectRow(at: index, animated: false, scrollPosition: .none)
            }
        } else {
            for index in self.selectedGirls {
                self.tableView.selectRow(at: index, animated: false, scrollPosition: .none)
            }
        }
    }
    
    //edit
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let thisPlayer : Player
            if genderSelector.selectedSegmentIndex == 0 {
                thisPlayer = boysThatArentPlaying()[indexPath.row]
                Player.deleteBoy(thisPlayer)
                self.selectedBoys.removeAll()
            }else {
                thisPlayer = girlsThatArentPlaying()[indexPath.row]
                Player.deleteGirl(thisPlayer)
                self.selectedGirls.removeAll()
            }
            
            self.tableView.reloadData()
        }
        
    }
    
}
