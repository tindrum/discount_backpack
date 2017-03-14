//
//  Calculator.swift
//  MVC example
//
//  Created by Daniel Henderson on 3/13/17.
//  Copyright © 2017 Daniel Henderson. All rights reserved.
//

class Calculator {
    // "The One Line Singleton" from
    // https://krakendev.io/blog/the-right-way-to-write-a-singleton
    // couldn't get his idea to work.
    
    
    init() {} // This prevents others from using the
                      // default '()' initializer for this class.
    
    // Property Observers from "Swift Programming: The Big Nerd Ranch Guide, 2nd Ed."
    // by M. Mathias and J. Gallagher, page 196
    var price:Float = 0.0 {
        didSet(oldValue) {
            if price != oldValue {
                calculateDiscount()
            }
        }
    }
    var dollarsOff:Float = 0.0 {
        didSet(oldValue) {
            if dollarsOff != oldValue {
                calculateDiscount()
            }
        }
    }
    var discount:Float = 0.0   { // a percent
        didSet(oldValue) {
            if discount != oldValue {
                calculateDiscount()
            }
        }
    }
    var otherDiscount:Float = 0.0  { // a percent
        didSet(oldValue) {
            if otherDiscount != oldValue {
                calculateDiscount()
            }
        }
    }
    var tax:Float = 0.0 {  // a percent

        didSet(oldValue) {
            if tax != oldValue {
                calculateDiscount()
            }
        }
    }
    
    var discountDisplay:Float = 0.0  //

    var discountPrice:Float = 0.0
    var moneySaved:Float = 0.0
    
    func calculateDiscount() {
        var workingPrice:Float = self.price
        workingPrice -= self.dollarsOff
        workingPrice *= ( 1.0 - self.discount )
        workingPrice *= ( 1.0 - self.otherDiscount )
        let salesTax:Float = self.tax * workingPrice
        self.discountPrice = workingPrice + salesTax
        self.moneySaved = self.price - self.discountPrice
        print("New discount price: " + String(self.discountPrice))
    }
    
    static let shared:Calculator = Calculator()
}
