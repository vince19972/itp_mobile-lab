//
//  Parrot.swift
//  ar-game
//
//  Created by 邵名浦 on 2019/4/4.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import SpriteKit
import GameplayKit

var spriteType = "twin"

class Bird : SKSpriteNode {
    
    var mainSprite = SKSpriteNode()
    
    func setup(){
        
        mainSprite = SKSpriteNode(imageNamed: spriteType)
        self.addChild(mainSprite)
        
        mainSprite.xScale = 0.1
        mainSprite.yScale = 0.1
        
        let textureAtals = SKTextureAtlas(named: spriteType)
        let frames = ["\(spriteType)_sprite_0", "\(spriteType)_sprite_1", "\(spriteType)_sprite_2", "\(spriteType)_sprite_3", "\(spriteType)_sprite_4", "\(spriteType)_sprite_5", "\(spriteType)_sprite_6", "\(spriteType)_sprite_7", "\(spriteType)_sprite_8", "\(spriteType)_sprite_9"].map{textureAtals.textureNamed($0)}
        
        let atlasAnimation = SKAction.animate(with: frames, timePerFrame: 1/7, resize: true, restore: false)
        
        let animationAction = SKAction.repeatForever(atlasAnimation)
        mainSprite.run(animationAction)
        
        // let duration = randomNumber(lowerBound: 0, upperBound: 5)
        let fade = SKAction.fadeOut(withDuration: TimeInterval(5))
        let removeBird = SKAction.run {
            self.removeFromParent()
        }
        
        let flySeqence = SKAction.sequence([fade, removeBird])
        
        mainSprite.run(flySeqence)
        
    }
    
}

func randomNumber (lowerBound lower:Int, upperBound upper:Int) -> Int {
    return Int(arc4random()) / Int(UInt32.max) * (lower - upper) + upper
}

