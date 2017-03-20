//
//  GraphView.swift
//  MVC example
//
//  Created by Daniel Henderson on 3/6/17.
//  Copyright © 2017 Daniel Henderson. All rights reserved.
//

import UIKit

extension CGContext {
    func setFillColor(_ hex:Int) {
        // Mask different values of the hex code
        // 0xFF0000 - Red
        // 0x00FF00 - Green
        // 0x0000FF - Blue
        
        let redColor:CGFloat = CGFloat(( hex >> 16) & 0xFF) / 255.0
        let greenColor:CGFloat = CGFloat(( hex >> 8) & 0xFF) / 255.0
        let blueColor:CGFloat = CGFloat( hex & 0xFF) / 255.0
        
        setFillColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }
}


class GraphView: UIView {
    let calcData:Calculator = Calculator.shared
    
    override func draw(_ rect: CGRect) {
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let margin:CGFloat = 16.0
        let columns:Int = 2
        var columnXPos:[CGFloat] = []
        let insetWidth:CGFloat = screenWidth - (2 * margin)
        let columnWidth:CGFloat = insetWidth / CGFloat(columns)
        // let rightGuide:CGFloat = screenWidth - 16.0
        let topGuide:CGFloat = 64.0 + 16.0
        let bottomGuide:CGFloat = screenHeight - 16.0
        let drawingHeight:CGFloat = screenHeight - 96.0
        
        let subRectangleHeight:CGFloat = drawingHeight * CGFloat(calcData.percentSpent)
        let subRectYPos:CGFloat = topGuide + ( drawingHeight * CGFloat(calcData.percentSaved))
        
        let drawOverrideLimit:CGFloat = 0.85 // percent overlap, may not scale for different screen sizes
        let drawOverride:Bool = ( subRectangleHeight / drawingHeight > drawOverrideLimit )

        
        for i in 0..<columns {
            columnXPos.append((insetWidth / CGFloat(columns)) * CGFloat(i) + margin)
        }

        // array of my favorite colors
        var colors: Array<Int> = [ 0xCCBC0E, 0xF7FF58, 0xD528FF ]
        
//        originalPrice.text = currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.originalPrice))!
//        discountPrice.text = currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.discountPrice))!

        // array of main text
        let headingText: Array<String> = ["Original Price", "You Saved", "You Pay"]
        let moneyText: Array<String> = [
            currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.originalPrice))!,
            currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.moneySaved))!,
            currencySymbol! + dollarFormatter.string(from: NSNumber(value:calcData.discountPrice))!
        ]
        let percentText: [String] = [ "",
                                      String(format: "%2.1f", calcData.percentSaved * 100) + "%",
                                      String(format: "%2.1f", calcData.percentSpent * 100) + "%"
                                    ]

        // Text Attributes
        let textAttributes = [
            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 16.0)!,
            NSForegroundColorAttributeName: UIColor(red:0.1, green:0.1, blue:0.1, alpha:1.0)
        ]
        
        // Draw Long rectangles and text
        context.setFillColor(colors[0])
        context.fill(CGRect(x:columnXPos[0], y:topGuide, width:columnWidth, height: drawingHeight))
        headingText[0].draw(at: CGPoint(x:columnXPos[0] + 16, y:topGuide + 16), withAttributes: textAttributes)
        moneyText[0].draw(at: CGPoint(x:columnXPos[0] + 16, y:topGuide + 33), withAttributes: textAttributes)
        percentText[0].draw(at: CGPoint(x:columnXPos[0] + 16, y:topGuide + 50), withAttributes: textAttributes)
    
        context.setFillColor(colors[1])
        context.fill(CGRect(x:columnXPos[1], y:topGuide, width:columnWidth, height: drawingHeight))
        if ( !drawOverride ) {
            headingText[1].draw(at: CGPoint(x:columnXPos[1] + 16, y:topGuide + 16), withAttributes: textAttributes)
            moneyText[1].draw(at: CGPoint(x:columnXPos[1] + 16, y:topGuide + 33), withAttributes: textAttributes)
            percentText[1].draw(at: CGPoint(x:columnXPos[1] + 16, y:topGuide + 50), withAttributes: textAttributes)
        }

        
        let i = 2
        context.setFillColor(colors[i])
        context.fill(CGRect(x:columnXPos[1], y:subRectYPos, width:columnWidth, height: subRectangleHeight))

        // if the bottom box is very small, 
        // don't let the text float below the bottom of the screen
        let textYPos:CGFloat
        if ( drawOverride ) {
            print("need to re-draw the text in the top box")
            let textAttributes3 = [
                NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 16.0)!,
                NSForegroundColorAttributeName: UIColor(red:0.7, green:0.8, blue:1.0, alpha:1.0)
            ]
            let aboveBottomRect:CGFloat = subRectYPos + 8
            headingText[1].draw(at: CGPoint(x:columnXPos[1] + 16, y:aboveBottomRect), withAttributes: textAttributes3)
            moneyText[1].draw(at: CGPoint(x:columnXPos[1] + 16, y:aboveBottomRect + 17), withAttributes: textAttributes3)
            percentText[1].draw(at: CGPoint(x:columnXPos[1] + 16, y:aboveBottomRect + 33), withAttributes: textAttributes3)

            // set discount text to the bottom of the rectangle
            textYPos = bottomGuide - 58
        }
        else if ( subRectangleHeight > 64 ) {
            textYPos = subRectYPos + 16
        } else {
            textYPos = bottomGuide - 58
        }
        let textAttributes2 = [
            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 16.0)!,
            NSForegroundColorAttributeName: UIColor(red:0.4, green:0.8, blue:1.0, alpha:1.0)
        ]

        headingText[i].draw(at: CGPoint(x:columnXPos[1] + 16, y:textYPos), withAttributes: textAttributes2)
        moneyText[i].draw(at: CGPoint(x:columnXPos[1] + 16, y:textYPos + 17), withAttributes: textAttributes2)
        percentText[i].draw(at: CGPoint(x:columnXPos[1] + 16, y:textYPos + 33), withAttributes: textAttributes2)
        
        
        
        
        // context.setFillColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
//        myText.draw(at: CGPoint(x:leftGuide + 16, y:topGuide + 16), withAttributes: textAttributes)
//        subText.draw(at: CGPoint(x:leftGuide + 16, y:topGuide + 36), withAttributes: textAttributes)
    }
 
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
