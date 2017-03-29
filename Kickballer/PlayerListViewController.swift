//
//  PlayerPickerViewController.swift
//  Kickballer
//
//  Created by Ryan Wedig on 8/22/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import Foundation
import UIKit

class PlayerListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var thisGame : Game?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genderPicker.selectedSegmentIndex == 0 {
            return thisGame!.boys.count
        } else {
            return thisGame!.girls.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Bench"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if genderPicker.selectedSegmentIndex == 0 {
                thisGame?.boys.remove(at: indexPath.row)
            } else {
                thisGame?.girls.remove(at: indexPath.row)
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var thisPlayer : Player
        if genderPicker.selectedSegmentIndex == 0 {
            thisPlayer = thisGame!.boys[indexPath.row]
        } else  {
            thisPlayer = thisGame!.girls[indexPath.row]
        }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = thisPlayer.name
        cell.detailTextLabel?.text = thisPlayer.gender.rawValue
        return cell
    }

    @IBAction func changedGender(_ sender: AnyObject) {
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? UINavigationController,
            let rootDesk = dest.topViewController as? PlayerPickerViewController {
            rootDesk.thisGame = self.thisGame
        }
        
    }

}
