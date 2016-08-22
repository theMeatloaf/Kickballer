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
    
    var thisGame = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        
        let ryan = Player()
        ryan.name = "Ryan"
        ryan.gender = .Male
        
        let rion = Player()
        rion.name = "Rion"
        rion.gender = .Female
        thisGame.boys = [ryan]
        thisGame.girls = [rion]
    }
    
    func updateUI() {
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
        if thisGame.outs > 0 {
            thisGame.outs -= 1
        }
        self.updateUI()
    }
    @IBAction func goNextKicker(sender: AnyObject) {
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? PlayerListViewController {
            dest.thisGame = self.thisGame
        }
    }
}

