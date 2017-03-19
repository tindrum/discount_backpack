//
//  ResultsViewController.swift
//  MVC example
//
//  Created by Daniel Henderson on 2/27/17.
//  Copyright © 2017 Daniel Henderson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    let calcData:Calculator = Calculator.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // add swipeRight gesture
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSwipe(_ sender: UIGestureRecognizer) {
        self.performSegue(withIdentifier: "unwindToCalc", sender: self)
    }

}
