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
// (1)
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

    /*
     MARK: CYCLE - viewDidLoad
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        /*-- draw arrows --*/
        let arrows = DrawArrow(canvasView: view).createPaths()
        view.layer.addSublayer(arrows.up)
        view.layer.addSublayer(arrows.right)
        view.layer.addSublayer(arrows.down)
        view.layer.addSublayer(arrows.left)
        
        /*-- websocket initialization --*/
        socket = WebSocket(url: URL(string: socketUrl)!)
        socket?.delegate = self
        socket?.connect()
    }
    
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

