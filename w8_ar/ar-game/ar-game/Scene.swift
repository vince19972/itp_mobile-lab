//
//  Scene.swift
//  ar-game
//
//  Created by 邵名浦 on 2019/4/3.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class Scene: SKScene {
    
    var numberOfBirds = 40
    var lastTime: TimeInterval = 0
    var debounce: TimeInterval = 5
    
    override func didMove(to view: SKView) {
        self.performInitialSpwan()
        
        let waitAction = SKAction.wait(forDuration: 0.5)
        let spwanAction = SKAction.run {
            self.performInitialSpwan()
        }
        
        self.run(SKAction.sequence([waitAction, spwanAction]))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (currentTime - lastTime > debounce) {
            print(currentTime - lastTime)
            spriteType = spriteType == "sleeping" ? "not-found" : "sleeping"
            lastTime = currentTime
        }
        spwanBird()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
    
    func performInitialSpwan() {
        for _ in 1 ... numberOfBirds {
            spwanBird()
        }
    }
    
    
    func spwanBird() {
        guard let sceneView = self.view as? ARSKView else {return}
        
        if let currentFrame = sceneView.session.currentFrame {
            var translation = matrix_identity_float4x4
            
//            translation.columns.3.x = randomPosition(lowerBound: -0.2, upperBound: 0.2) // -1.5 1.5
//            translation.columns.3.y = randomPosition(lowerBound: -0.2, upperBound: 0.2) // -1.5 1.5
//            translation.columns.3.z = randomPosition(lowerBound: -0.5, upperBound: -0.2) // -2 2
            
            translation.columns.3.z = -0.2
            
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
    
}

func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float {
    return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
}
