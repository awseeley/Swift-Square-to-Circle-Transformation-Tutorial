//
//  ViewController.swift
//  SquareToCircle
//
//  Created by Andrew Seeley on 5/2/17.
//  Copyright © 2017 Seemu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Holds the shape layers
    let squareLayer = CAShapeLayer()
    let circleLayer = CAShapeLayer()
    // Tells us if the current shape is a square
    var isSquare = true
    // Stores and sets the animation
    var layerAnimation = CABasicAnimation(keyPath: "path")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The position of our shapes
        let layerCenter = CGPoint(x: 200, y: 200)
        
        // Setup the square layer & add it
        let square = squarePathWithCenter(center: layerCenter, side: 100)
        squareLayer.path = square.cgPath
        squareLayer.fillColor = UIColor.red.cgColor
        self.view.layer.addSublayer(squareLayer)
        
        // Setup the circle layer
        let circle = circlePathWithCenter(center: layerCenter, radius: 70)
        circleLayer.path = circle.cgPath
        circleLayer.fillColor = UIColor.red.cgColor
        
        // Setup animation values that dont change
        layerAnimation.duration = 1
        // Sets the animation style. You can change these to see how it will affect the animations.
        layerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layerAnimation.fillMode = kCAFillModeForwards
        // Dont remove the shape when the animation has been completed
        layerAnimation.isRemovedOnCompletion = false
    }
    
    // Every time you touch the screen this function is run
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the first area we touched on the device
        let touch = touches.first
        // Get the point coordinates we touched on the device
        let point = touch!.location(in: self.view)
        // If we tapped on the circle or square then change the shape
        if squareLayer.path!.contains(point) || circleLayer.path!.contains(point) {
            
            if isSquare {
                // If we have a square change the shape to a circle
                layerAnimation.fromValue = squareLayer.path
                layerAnimation.toValue = circleLayer.path
                self.squareLayer.add(layerAnimation, forKey: "animatePath");
            } else {
                // AIf we have a circle change the shape to a square
                layerAnimation.fromValue = circleLayer.path
                layerAnimation.toValue = squareLayer.path
                self.squareLayer.add(layerAnimation, forKey: "animatePath");
            }
            // Set isSquare to the opposite.
            isSquare = !isSquare
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(M_PI), endAngle: -CGFloat(M_PI/2), clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(M_PI/2), endAngle: 0, clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI/2), clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(M_PI), clockwise: true)
        circlePath.close()
        return circlePath
    }
    
    func squarePathWithCenter(center: CGPoint, side: CGFloat) -> UIBezierPath {
        let squarePath = UIBezierPath()
        let startX = center.x - side / 2
        let startY = center.y - side / 2
        squarePath.move(to: CGPoint(x: startX, y: startY))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.addLine(to: CGPoint(x: startX + side, y: startY))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.addLine(to: CGPoint(x: startX + side, y: startY + side))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.addLine(to: CGPoint(x: startX, y: startY + side))
        squarePath.addLine(to: squarePath.currentPoint)
        squarePath.close()
        return squarePath
    }


}

