//
//  CalculatorViewController.swift
//  MVC example
//
//  Created by Daniel Henderson on 2/27/17.
//  Copyright © 2017 Daniel Henderson. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make Swipe Gestures
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
        // handleSwipe is a function down below...
        // #selector() selects and executes that function

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "showResults", sender: self)
    }
    
    // Enable unwinding other views
    @IBAction func unwindToCalc(segue:UIStoryboardSegue) {}
    
}
