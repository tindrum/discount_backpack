//
//  CalculatorViewController.swift
//  MVC example
//
//  Created by Daniel Henderson on 2/27/17.
//  Copyright © 2017 Daniel Henderson. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    let calcData:Calculator = Calculator()
    
    @IBAction func editChanged(_ sender: UITextField) {
        switch sender {
        case price:
            calcData.price = Float(sender.text!)!
        case dollarsOff:
            calcData.dollarsOff = Float(sender.text!)!
        case discount:
            calcData.discount = Float(sender.text!)!
        case otherDiscount:
            calcData.otherDiscount = Float(sender.text!)!
        case tax:
            calcData.tax = Float(sender.text!)!
        default:
            print("what text field got clicked?")
        }
    }
    
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var dollarsOff: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var otherDiscount: UITextField!
    @IBOutlet weak var tax: UITextField!
    
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    
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
