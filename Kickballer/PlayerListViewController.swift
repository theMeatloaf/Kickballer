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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genderPicker.selectedSegmentIndex == 0 {
            return thisGame!.boys.count
        } else {
            return thisGame!.girls.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var thisPlayer : Player
        if genderPicker.selectedSegmentIndex == 0 {
            thisPlayer = thisGame!.boys[indexPath.row]
        } else  {
            thisPlayer = thisGame!.girls[indexPath.row]
        }
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = thisPlayer.name
        cell.detailTextLabel?.text = thisPlayer.gender.rawValue
        return cell
    }

    @IBAction func changedGender(sender: AnyObject) {
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let dest = segue.destinationViewController as? UINavigationController,
            let rootDesk = dest.topViewController as? PlayerPickerViewController {
            rootDesk.thisGame = self.thisGame
        }
        
    }

}