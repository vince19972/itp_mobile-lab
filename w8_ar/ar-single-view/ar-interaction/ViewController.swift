//
//  ViewController.swift
//  ar-interaction
//
//  Created by 邵名浦 on 2019/4/3.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController : ARSKViewDelegate {
    
    /*func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        <#code#>
    }*/
    
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        let birdNode = SKSpriteNode(imageNamed: "standard_parrot")
        birdNode.xScale = 0.25
        birdNode.yScale = 0.25
        
        node.addChild(birdNode)
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}
