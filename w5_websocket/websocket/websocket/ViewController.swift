//
//  ViewController.swift
//  websocket
//
//  Created by 邵名浦 on 2019/3/4.
//  Copyright © 2019 vinceshao. All rights reserved.
//

/*--------- REFERENCE CREDITS ---------*/
//
// Structure of the code is based on MobileLab code kit: https://github.com/mobilelabclass/mobile-lab-websocket-kit
//
// (1) Detecting tap on layer: https://stackoverflow.com/questions/29773165/detecting-a-tap-on-a-cashapelayer-in-swift
//
//
/*-------------------------------------*/

import UIKit
import Starscream

/*
 MARK: global variables
*/
private let socketUrl = "wss://gameserver.mobilelabclass.com"

enum DirectionCode: String {
    case up = "0"
    case right = "1"
    case down = "2"
    case left = "3"
}


/*
 MARK: view controller
*/
class ViewController: UIViewController, WebSocketDelegate {
    
    /*
     MARK: class variables
    */
    var socket: WebSocket?
    var arrows: DrawArrow.FourArrows?
    
    struct GyroValues {
        var x: Double
        var y: Double
        var z: Double
    }

    /*
     MARK: CYCLE - viewDidLoad
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*-- styling --*/
        view.backgroundColor = UIColor.black
        
        /*-- draw arrows --*/
        arrows = DrawArrow(canvasView: view).createPaths()
        view.layer.addSublayer(arrows!.up)
        view.layer.addSublayer(arrows!.right)
        view.layer.addSublayer(arrows!.down)
        view.layer.addSublayer(arrows!.left)
        
        /*-- websocket initialization --*/
        socket = WebSocket(url: URL(string: socketUrl)!)
        socket?.delegate = self
        socket?.connect()
    }
    
    /* REFERENCE CREDIT - (1) */
    // touches on layers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get touch data
        let touch = touches.first
        guard let point = touch?.location(in: view) else { return }
        
        // touch position condition
        let heightDivision = view.frame.size.height / 3
        let widthDivision = view.frame.size.width / 2
        let isUp = point.y < heightDivision
        let isDown = point.y > heightDivision * 2
        let isLeft = point.x < widthDivision
        
        // actions based on touch position
        if isUp || isDown {
            if isUp {
                updateStyle(arrows!.up)
            } else {
                updateStyle(arrows!.down)
            }
        } else {
            if isLeft {
                updateStyle(arrows!.left)
            } else {
                updateStyle(arrows!.right)
            }
        }
    }
    
    /*
     MARK: helper functions
    */
    // update arrow style based on action
    func updateStyle(_ tappedArrow: CAShapeLayer) {
        // reset to default
        arrows!.up.zPosition = 1
        arrows!.right.zPosition = 1
        arrows!.down.zPosition = 1
        arrows!.left.zPosition = 1
        arrows!.up.strokeColor = UIColor.orange.cgColor
        arrows!.right.strokeColor = UIColor.orange.cgColor
        arrows!.down.strokeColor = UIColor.orange.cgColor
        arrows!.left.strokeColor = UIColor.orange.cgColor
        
        // update target
        tappedArrow.zPosition = 10
        tappedArrow.strokeColor = UIColor.yellow.cgColor
    }
    
    /*
     MARK: websockets functions
    */
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }


}

