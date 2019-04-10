//
//  Game.swift
//  paper-scissors-stone
//
//  Created by 邵名浦 on 2019/4/9.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import Foundation
import UIKit

class Game {
    
    enum gameKeyWord: String {
        case paper = "paper"
        case scissors = "scissors"
        case stone = "stone"
    }
    
    func processWord(input: String, topHand: UILabel, bottomHand: UILabel) -> String {
        
        let randomNum = Int.random(in: 0 ... 2)
        let fmtString = input.lowercased()
        
        switch fmtString {
            case gameKeyWord.paper.rawValue:
                bottomHand.text = "🖐"
            case gameKeyWord.scissors.rawValue:
                bottomHand.text = "✌️"
            case "caesars":
                bottomHand.text = "✌️"
            case gameKeyWord.stone.rawValue:
                bottomHand.text = "👊"
            default:
                print("nothing")
        }
        
        switch randomNum {
            case 0:
                topHand.text = "🖐"
            case 1:
                topHand.text = "✌️"
            case 2:
                topHand.text = "👊"
            default:
                print("nothing")
        }
        
        if (topHand.text == "🖐") {
            switch bottomHand.text {
                case "🖐":
                    print("even")
                    return("even")
                case "✌️":
                    print("win")
                    return("win")
                case "👊":
                    print("lose")
                    return("lose")
                default:
                    print("even")
                    return("even")
            }
        }
        if (topHand.text == "✌️") {
            switch bottomHand.text {
                case "🖐":
                    print("lose")
                    return("lose")
                case "✌️":
                    print("even")
                    return("even")
                case "👊":
                    print("win")
                    return("win")
                default:
                    print("even")
                    return("even")
            }
        }
        if (topHand.text == "👊") {
            switch bottomHand.text {
                case "🖐":
                    print("win")
                    return("win")
                case "✌️":
                    print("lose")
                    return("lose")
                case "👊":
                    print("even")
                    return("even")
                default:
                    print("even")
                    return("even")
            }
        }
        
        //        switch fmtString {
        //            case gameKeyWord.paper.rawValue:
        //                if (readyToGo) {
        //                    gameWordArray.append(gameKeyWord.paper.rawValue)
        //                }
        //                if (gameWordArray.count == 0) {
        //                    gameWordArray.insert(gameKeyWord.paper.rawValue, at: 0)
        //                }
        //            case gameKeyWord.scissors.rawValue:
        //                if (readyToGo) {
        //                    gameWordArray.append(gameKeyWord.scissors.rawValue)
        //                }
        //                if (gameWordArray.count == 1) {
        //                    if (gameWordArray[0] == gameKeyWord.paper.rawValue) {
        //                        gameWordArray.insert(gameKeyWord.scissors.rawValue, at: 1)
        //                    }
        //                }
        //            case "caesars":
        //                if (readyToGo) {
        //                    gameWordArray.append(gameKeyWord.scissors.rawValue)
        //                }
        //                if (gameWordArray.count == 1) {
        //                    if (gameWordArray[0] == gameKeyWord.paper.rawValue) {
        //                        gameWordArray.insert(gameKeyWord.scissors.rawValue, at: 1)
        //                    }
        //                }
        //            case gameKeyWord.stone.rawValue:
        //                if (readyToGo) {
        //                    gameWordArray.append(gameKeyWord.stone.rawValue)
        //                }
        //                if (gameWordArray.count == 2) {
        //                    if (
        //                        gameWordArray[0] == gameKeyWord.paper.rawValue &&
        //                        gameWordArray[1] == gameKeyWord.scissors.rawValue
        //                    ) {
        //                        gameWordArray.insert(gameKeyWord.stone.rawValue, at: 2)
        //                        readyToGo = true
        //                    }
        //                }
        //            default:
        //                readyToGo = false
        //        }
        
        //        if (readyToGo && gameWordArray.count == 4) {
        //            switch gameWordArray[3] {
        //                case gameKeyWord.paper.rawValue:
        //                    bottomHand.text = "🖐"
        //                case gameKeyWord.scissors.rawValue:
        //                    bottomHand.text = "✌️"
        //                case "caesars":
        //                    bottomHand.text = "✌️"
        //                case gameKeyWord.stone.rawValue:
        //                    bottomHand.text = "👊"
        //                default:
        //                    readyToGo = false
        //            }
        //            gameWordArray = []
        //            readyToGo = false
        //        }
        
        return("even")
    }
    
}
