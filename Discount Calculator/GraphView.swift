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

        
        for i in 0..<columns {
            columnXPos.append((insetWidth / CGFloat(columns)) * CGFloat(i) + margin)
        }

        // array of my favorite colors
        var colors: Array<Int> = [ 0xD528FF, 0xF7FF58, 0xCCBC0E ]
        
        // array of main text
        let headingText: Array<String> = ["Original Price", "You Saved", "You Pay"]
        let moneyText: Array<String> = [ String(calcData.originalPrice), String(calcData.moneySaved), String(calcData.discountPrice)]
        let percentText: [String] = [ "", String(calcData.percentSaved), String(calcData.percentSpent)] // TODO: have model calculate percents

        // Text Attributes
        let textAttributes = [
            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 16.0)!,
            NSForegroundColorAttributeName: UIColor(red:0.1, green:0.1, blue:0.1, alpha:1.0)
        ]
        
        // Draw Long rectangles and text
        for i in 0..<2 {
            context.setFillColor(colors[i])
            context.fill(CGRect(x:columnXPos[i], y:topGuide, width:columnWidth, height: drawingHeight))
            headingText[i].draw(at: CGPoint(x:columnXPos[i] + 16, y:topGuide + 16), withAttributes: textAttributes)
            moneyText[i].draw(at: CGPoint(x:columnXPos[i] + 16, y:topGuide + 33), withAttributes: textAttributes)
            percentText[i].draw(at: CGPoint(x:columnXPos[i] + 16, y:topGuide + 50), withAttributes: textAttributes)
            
        }
        
        let i = 2
        let subRectangleHeight:CGFloat = drawingHeight * CGFloat(calcData.percentSpent)
        let subRectYPos:CGFloat = topGuide + ( drawingHeight * CGFloat(calcData.percentSaved))
        
        context.setFillColor(colors[i])
        context.fill(CGRect(x:columnXPos[1], y:subRectYPos, width:columnWidth, height: subRectangleHeight))
        headingText[i].draw(at: CGPoint(x:columnXPos[1] + 16, y:subRectYPos + 16), withAttributes: textAttributes)
        moneyText[i].draw(at: CGPoint(x:columnXPos[1] + 16, y:subRectYPos + 33), withAttributes: textAttributes)
        percentText[i].draw(at: CGPoint(x:columnXPos[1] + 16, y:subRectYPos + 50), withAttributes: textAttributes)
        
        
        
        
        // context.setFillColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
//        myText.draw(at: CGPoint(x:leftGuide + 16, y:topGuide + 16), withAttributes: textAttributes)
//        subText.draw(at: CGPoint(x:leftGuide + 16, y:topGuide + 36), withAttributes: textAttributes)
    }
 

}
