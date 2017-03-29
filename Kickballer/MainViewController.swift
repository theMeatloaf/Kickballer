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
        thisGame.boys = []
        thisGame.girls = []
        self.updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateUI()
    }
    
    func updateUI() {
        self.checkForOverflow()
        
        if onBoys {
            whosUpLabel.text = thisGame.boys.isEmpty ? "N/A" : thisGame.boys[thisGame.boyCounter].name
            onDeckLabel.text = thisGame.girls.isEmpty ? "N/A" : thisGame.girls[thisGame.girlCounter].name
        } else {
             whosUpLabel.text = thisGame.girls.isEmpty ? "N/A" : thisGame.girls[thisGame.girlCounter].name
             onDeckLabel.text = thisGame.boys.isEmpty ? "N/A" : thisGame.boys[thisGame.boyCounter].name
        }

        outsCounter.text = "\(thisGame.outs)"
        pointsCounter.text = "\(thisGame.point)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func outsUp(_ sender: AnyObject) {
        thisGame.outs += 1
        if thisGame.outs == 4 {
            thisGame.outs = 0
        }
        self.updateUI()
    }

    @IBAction func outsDown(_ sender: AnyObject) {
        if thisGame.outs > 0 {
           thisGame.outs -= 1
        }
        self.updateUI()
    }
    
    @IBAction func pointsUp(_ sender: AnyObject) {
        thisGame.point += 1
        self.updateUI()
    }

    @IBAction func pointsDown(_ sender: AnyObject) {
        if thisGame.point > 0 {
            thisGame.point -= 1
        }
        self.updateUI()
    }
    @IBAction func goNextKicker(_ sender: AnyObject) {
        if onBoys {
            thisGame.boyCounter += 1
        } else {
            thisGame.girlCounter += 1
        }
        onBoys = !onBoys
        
        self.checkForOverflow()
        
        self.updateUI()
    }
    
    func checkForOverflow() {
        if thisGame.boyCounter >= thisGame.boys.count {
            thisGame.boyCounter = 0
        }
        
        if thisGame.girlCounter >= thisGame.girls.count {
            thisGame.girlCounter = 0
        }
    }
    
    @IBAction func goLastKicker(_ sender: AnyObject) {
        onBoys = !onBoys

        if onBoys {
            thisGame.boyCounter -= 1
        } else {
            thisGame.girlCounter -= 1
        }
        
        if thisGame.boyCounter == -1 {
            thisGame.boyCounter = thisGame.boys.count - 1
        }
        
        if thisGame.girlCounter == -1 {
            thisGame.girlCounter = thisGame.girls.count - 1
        }
        
        self.updateUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PlayerListViewController {
            dest.thisGame = self.thisGame
        }
    }
}

