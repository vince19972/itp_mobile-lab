//
//  ElementCreation.swift
//  paper-scissors-stone
//
//  Created by 邵名浦 on 2019/4/9.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import Foundation
import UIKit

class ElementCreation {
    
    func makeMainContainer(parentController: ViewController, isTopHalf: Bool = true) -> UIView {
        let container = UIView()
        
        parentController.view.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: parentController.view.frame.height / 2).isActive = true
        container.widthAnchor.constraint(equalToConstant: parentController.view.frame.width).isActive = true
        container.bounds.size.width = parentController.view.frame.width
        container.bounds.size.height = parentController.view.frame.height
        
        if (isTopHalf) {
            container.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
            container.backgroundColor = UIColor(red:0.89, green:0.95, blue:0.99, alpha:1.0)
        } else {
            container.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
            container.backgroundColor = UIColor(red:0.99, green:0.89, blue:0.93, alpha:1.0)
        }
        
        return container
    }
    
    func makeHands(parentContainer: UIView, isTopHalf: Bool = true) -> UILabel {
        let hand = UILabel()
        
        parentContainer.addSubview(hand)
        
        hand.translatesAutoresizingMaskIntoConstraints = false
        hand.topAnchor.constraint(equalTo: parentContainer.topAnchor).isActive = true
        hand.bottomAnchor.constraint(equalTo: parentContainer.bottomAnchor).isActive = true
        hand.leadingAnchor.constraint(equalTo: parentContainer.leadingAnchor).isActive = true
        hand.trailingAnchor.constraint(equalTo: parentContainer.trailingAnchor).isActive = true
        
        hand.numberOfLines = 1
        hand.adjustsFontSizeToFitWidth = true
        hand.font = hand.font.withSize(parentContainer.frame.size.width / 4)
        hand.textAlignment = .center
        hand.text = "✌️"
        
        if (!isTopHalf) {
            hand.isHidden = true
        }
        
        return hand
    }
    
    func button(buttonText: String) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        
        return button
    }
    
    func gradientBackground(_ parentContainer: UIView) -> CAGradientLayer {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red:0.46, green:1.00, blue:1.00, alpha:1.0).cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame = parentContainer.bounds
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        gradient.colors = [colorTop, colorBottom]
        gradient.locations =  [-0.5, 1.5]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [colorTop, colorBottom]
        animation.toValue = [colorBottom, colorTop]
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        gradient.add(animation, forKey: nil)
        
        return gradient
    }
    
}
