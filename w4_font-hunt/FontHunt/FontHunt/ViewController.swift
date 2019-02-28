//
//  ViewController.swift
//  FontHunt
//
//  Created by 邵名浦 on 2019/2/27.
//  Copyright © 2019 vinceshao. All rights reserved.
//


/*--------- REFERENCE CREDITS ---------*/
//
//
// (1) Using child view controllers: http://www.rexfeng.com/blog/2018/02/how-to-use-child-view-controllers-in-swift-4-0-programmatically/
// (2) Transition animation: https://stackoverflow.com/questions/37722323/how-to-present-view-controller-from-right-to-left-in-ios-using-swift
//
//
/*-------------------------------------*/


import UIKit

/*
 
MARK: global variables
 
*/
let FOOTER_HEIGHT: CGFloat = 48
let FOOTER_ICON_SIZE: CGFloat = 20

struct Font: Codable {
    var date: String
    var location: String
    var imagePath: String
    var fontClass: String
    var fontStyle: String
    var note: String
}
private let FontStackKey = "FONT_STACK_KEY"


/*
 
MARK: view controller
 
*/

class ViewController: UIViewController {
    
    /*
    MARK: child table
    */
    var fontStack = [Font]()
    let childTableVC = MainTableViewController()        // create child VC
    
    
    /*
    MARK: view did load
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        MARK: delegating child view controllers
        */
        
        // table VC
        /* REFERENCE CREDIT - (1) */
        self.addChild(childTableVC)                         // set child VC
        self.view.addSubview(childTableVC.view)             // add child VC's view to parent
        childTableVC.didMove(toParent: self)                // register child VC
        

        /*
        MARK: creating sub views
        */
        // footer
        let footerView = UIView(frame: CGRect(
            x: 0,
            y: self.view.frame.height - FOOTER_HEIGHT,
            width: self.view.frame.width,
            height: FOOTER_HEIGHT)
        )
        footerView.backgroundColor = UIColor(
            red: 0.95,
            green: 0.95,
            blue: 0.95,
            alpha: 1.0
        )
        self.view.addSubview(footerView)
        
        let footer_addImage = UIButton(frame: CGRect(
            x: footerView.frame.width / 2 - FOOTER_ICON_SIZE / 2,
            y: footerView.frame.height / 2 - FOOTER_ICON_SIZE / 2,
            width: FOOTER_ICON_SIZE,
            height: FOOTER_ICON_SIZE)
        )
        footer_addImage.setImage(UIImage(named: "addImage.png"), for: .normal)
        footer_addImage.addTarget(self, action: #selector(self.addImage(_:)), for: .touchUpInside)
        footerView.addSubview(footer_addImage)
    }
    
    /*
    MARK: event listeners
    */
    @objc func addImage(_ sender: UIButton!) {
        // Instantiate View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as? ModalViewController else {
            print("Error instantiating ActionViewController" )
            return
        }
        
        // Define a closure to be called in ActionViewController,
        // which will use the elementArray transported from this controller
        vc.didSaveElement = { [weak self] font in
            self?.fontStack.append(font)
            
            // Resave element array into User defaults.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self?.fontStack), forKey: FontStackKey)
            
            self?.childTableVC.tableView.reloadData()
        }
        
        // Present view controller.
        /* REFERENCE CREDIT - (2) */
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(vc, animated: false, completion: nil)
    }
}

