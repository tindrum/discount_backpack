//
//  CalculatorViewController.swift
//  MVC example
//
//  Created by Daniel Henderson on 2/27/17.
//  Copyright © 2017 Daniel Henderson. All rights reserved.
//

import UIKit

// get currencty symbol from locale 
// iOS Programming pg 121
let currentLocale = Locale.current
let currencySymbol = currentLocale.currencySymbol

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    let calcData:Calculator = Calculator()
    var currentTextField:UITextField?
    
    
    @IBAction func editChanged(_ sender: UITextField) {
        if Float(sender.text!) != nil {
            switch sender {
                case price:
                    calcData.price = Float(sender.text!)!
                case dollarsOff:
                    calcData.dollarsOff = Float(sender.text!)!
                case discount:
                    calcData.discount = Float(sender.text!)! / 100.0
                case otherDiscount:
                    calcData.otherDiscount = Float(sender.text!)! / 100.0
                case tax:
                    calcData.tax = Float(sender.text!)! / 100.0
                default:
                    print("what text field got clicked?")
            }
            originalPrice.text = currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.originalPrice))!
            discountPrice.text = currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.discountPrice))!
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        if (currentTextField != nil) {
            currentTextField?.resignFirstResponder()
            print("resigning first responder")
        }
    }
    
    // UITextField Delegate from "Swift Programming: The Big Nerd Ranch Guide, 2nd Ed."
    // by M. Mathias and J. Gallagher, page 84
    //
    // If there is already a decimal in the number,
    // suppress the addition of another one.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case price, dollarsOff:
            let moneyString:String = convertToMoney(textField.text)
            textField.text = moneyString
        case discount, otherDiscount, tax:
            let percentString:String = convertToPercent(textField.text)
            textField.text = percentString
        default:
            print("what text field got edited?")
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
    
    // Number formatters from "Swift Programming: The Big Nerd Ranch Guide, 2nd Ed."
    // by M. Mathias and J. Gallagher, page 81
    //
    // If there is already a decimal in the number,
    // suppress the addition of another one.
    let dollarFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    // It is strange that the text must be converted to Float
    // in order to use the format string.
    // I guess anything but a number of some sort
    // can't be searched for a place for the decimal point.
    func convertToMoney(_ text: String?) -> String {
        if (text != nil){
            if (text != "") {
                return String(format: "%1.2f", Float(text!)!)
            } else {
                // will crash on empty text field if no value given back
                return "0.00"
            }
        } else {
            return "0.00"
        }
    }

    func convertToPercent(_ text: String?) -> String {
        if (text != nil) {
            if (text != "") {
                return String(format: "%2.2f", Float(text!)!)
            } else {
                // will crash on empty text field if no value given back
                return "0.00"
            }
        } else {
            return "00.00"
        }
    }
}
