//
//  ViewController.swift
//  Kickballer
//
//  Created by Ryan Wedig on 8/22/16.
//  Copyright © 2016 Ryan Wedig. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var whosUpLabel: UILabel!
    @IBOutlet weak var onDeckLabel: UILabel!
    @IBOutlet weak var outsCounter: UILabel!
    @IBOutlet weak var pointsCounter: UILabel!
    
    var onBoys = true
    var thisGame = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ryan = Player()
        ryan.name = "Ryan"
        ryan.gender = .Male
        
        let rion = Player()
        rion.name = "Rion"
        rion.gender = .Female
        thisGame.boys = [ryan]
        thisGame.girls = [rion]
        
        self.updateUI()
    }
    
    func updateUI() {
        if onBoys {
            whosUpLabel.text = thisGame.boys[thisGame.boyCounter].name
            onDeckLabel.text = thisGame.girls[thisGame.girlCounter].name
        } else {
            whosUpLabel.text = thisGame.girls[thisGame.girlCounter].name
            onDeckLabel.text = thisGame.boys[thisGame.boyCounter].name
        }

        outsCounter.text = "\(thisGame.outs)"
        pointsCounter.text = "\(thisGame.point)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func outsUp(sender: AnyObject) {
        thisGame.outs += 1
        if thisGame.outs == 4 {
            thisGame.outs = 0
        }
        self.updateUI()
    }

    @IBAction func outsDown(sender: AnyObject) {
        if thisGame.outs > 0 {
           thisGame.outs -= 1
        }
        self.updateUI()
    }
    
    @IBAction func pointsUp(sender: AnyObject) {
        thisGame.point += 1
        self.updateUI()
    }

    @IBAction func pointsDown(sender: AnyObject) {
        if thisGame.point > 0 {
            thisGame.point -= 1
        }
        self.updateUI()
    }
    @IBAction func goNextKicker(sender: AnyObject) {
        if onBoys {
            thisGame.boyCounter += 1
        } else {
            thisGame.girlCounter += 1
        }
        onBoys = !onBoys
        
        if thisGame.boyCounter == thisGame.boys.count {
            thisGame.boyCounter = 0
        }
        
        if thisGame.girlCounter == thisGame.girls.count {
            thisGame.girlCounter = 0
        }
        
        self.updateUI()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? PlayerListViewController {
            dest.thisGame = self.thisGame
        }
    }
}

