//
//  drawArrow.swift
//  websocket
//
//  Created by 邵名浦 on 2019/3/5.
//  Copyright © 2019 vinceshao. All rights reserved.
//

/*--------- REFERENCE CREDITS ---------*/
//
//
// (1) Drawing bezier path: https://stackoverflow.com/questions/21311880/drawing-uibezierpath-on-code-generated-uiview
//
// (2) Draw bezier shapes: https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E9%81%8B%E7%94%A8-uibezierpath-%E7%B9%AA%E8%A3%BD%E5%BD%A2-3c858e194676
//
// (3) Bezier stroke only: https://stackoverflow.com/questions/46721363/mask-uiview-with-uibezierpath-stroke-only
//
/*-------------------------------------*/

import Foundation
import UIKit

class DrawArrow {
    
    var canvasView: UIView
    
    init(canvasView: UIView) {
        self.canvasView = canvasView
    }
    
    /*
     MARK: defining data type
    */
    enum Direction: String {
        case up = "up"
        case right = "right"
        case down = "down"
        case left = "left"
    }
    
    struct Coordinations {
        var x: CGFloat
        var y: CGFloat
    }
    
    struct ArrowPoints {
        var first: Coordinations
        var second: Coordinations
        var third: Coordinations
    }
    
    struct FourArrows {
        var up: CAShapeLayer
        var right: CAShapeLayer
        var down: CAShapeLayer
        var left: CAShapeLayer
    }
    
    /*
     MARK: functions
     */
    func getCoordinations(_ direction: Direction) -> ArrowPoints {
        var firstPoint: Coordinations
        var secondPoint: Coordinations
        var thirdPoint: Coordinations
        
        let viewWidth = self.canvasView.frame.size.width
        let viewHeight = self.canvasView.frame.size.height
        
        switch direction {
            case .up:
                firstPoint = Coordinations(x: 0, y: viewHeight/2)
                secondPoint = Coordinations(x: viewWidth/2, y: 0)
                thirdPoint = Coordinations(x: viewWidth, y: viewHeight/2)
            case .right:
                firstPoint = Coordinations(x: viewWidth/2, y: 0)
                secondPoint = Coordinations(x: viewWidth, y: viewHeight/2)
                thirdPoint = Coordinations(x: viewWidth/2, y: viewHeight)
            case .down:
                firstPoint = Coordinations(x: viewWidth, y: viewHeight/2)
                secondPoint = Coordinations(x: viewWidth/2, y: viewHeight)
                thirdPoint = Coordinations(x: 0, y: viewHeight/2)
            case .left:
                firstPoint = Coordinations(x: viewWidth/2, y: viewHeight)
                secondPoint = Coordinations(x: 0, y: viewHeight/2)
                thirdPoint = Coordinations(x: viewWidth/2, y: 0)
        }
        
        return ArrowPoints(first: firstPoint, second: secondPoint, third: thirdPoint)
    }
    
    /* REFERENCE CREDIT - (1) */
    // create bezier path
    func createBezierPath(_ points: ArrowPoints) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        /* REFERENCE CREDIT - (2) */
        // draw bezier shapes
        path.move(to: CGPoint(x: points.first.x, y: points.first.y))
        path.addLine(to: CGPoint(x: points.second.x, y: points.second.y))
        path.addLine(to: CGPoint(x: points.third.x, y: points.third.y))
        
        return path
    }
    
    func createLayer(_ points: ArrowPoints) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createBezierPath(points).cgPath
        
        /* REFERENCE CREDIT - (3) */
        // stroke only
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = nil
        
        return shapeLayer
    }
    
    // export four paths created
    func createPaths() -> FourArrows {
        let upArrowLayer = createLayer(getCoordinations(.up))
        let rightArrowLayer = createLayer(getCoordinations(.right))
        let downArrowLayer = createLayer(getCoordinations(.down))
        let leftArrowLayer = createLayer(getCoordinations(.left))
        
        return FourArrows(up: upArrowLayer, right: rightArrowLayer, down: downArrowLayer, left: leftArrowLayer)
    }
    
}
