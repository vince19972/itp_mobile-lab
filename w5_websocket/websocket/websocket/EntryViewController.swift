//
//  EntryViewController.swift
//  websocket
//
//  Created by 邵名浦 on 2019/3/5.
//  Copyright © 2019 vinceshao. All rights reserved.
//

/*--------- REFERENCE CREDITS ---------*/
//
//
// (1) TextField padding: https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
//
//
/*-------------------------------------*/

import UIKit

/*
 MARK: global variables
 */
let playerIdKey = "PLAYER_ID"

/*
 MARK: view controller
 */
class EntryViewController: UIViewController, UITextFieldDelegate {
    
    /*
     class variables
    */
    var defaults: UserDefaults!

    /*
     life cycle
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true

        /*-- styling --*/
        view.backgroundColor = UIColor.black
        
        /*
         MARK: subviews create
        */
        // text field
        let playerTextField: TextField = {
            let textField = TextField()
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.backgroundColor = UIColor.black
            textField.layer.borderColor = UIColor.orange.cgColor
            textField.layer.borderWidth = 1
            textField.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            textField.textColor = UIColor.orange
            textField.attributedPlaceholder = NSAttributedString(
                string: "your player ID please",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange]
            )
            textField.returnKeyType = UIReturnKeyType.done
            
            return textField
        }()
        
        // add subview
        view.addSubview(playerTextField)
        
        // constraints
        playerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // delegate
        playerTextField.delegate = self
        
        
        /*-- user defaults --*/
        // Init user defaults object for storage.
        defaults = UserDefaults.standard
        
        // Get USER DEFAULTS data
        // If there is a player id saved, set text field.
        if let playerId = defaults.string(forKey: playerIdKey) {
            playerTextField.text = playerId
        }
    }
    
    /*
     MARK: actions
    */
    // Textfield delegate method
    // Update player id in user defaults when "Done" is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        // Check text field is not empty, otherwise save to user defaults.
        if (textField.text?.isEmpty)! {
            presentAlertMessage(message: "Enter Valid Player Id")
            textField.text = defaults.string(forKey: playerIdKey)!
        } else {
            defaults.set(textField.text!, forKey: playerIdKey)
            
            // Instantiate View Controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "BoardViewController") as? BoardViewController else {
                print("Error instantiating ActionViewController" )
                return false
            }
            
            vc.defaultStore = defaults
            
            // Present view controller.
            present(vc, animated: true, completion: nil)
        }
        
        return false
    }
    
    /*
     MARK: helper functions
    */
    // Helper method for displaying a alert view.
    func presentAlertMessage(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


/* REFERENCE CREDIT - (1) */
// textField padding
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
