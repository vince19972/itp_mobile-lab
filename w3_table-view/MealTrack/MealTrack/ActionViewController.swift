//
//  ActionViewController.swift
//  MealTrack
//
//  Created by 邵名浦 on 2019/2/19.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func handleSaveButton(_ sender: UIBarButtonItem) {
        print("test")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleCancelButton(_ sender: UIBarButtonItem) {
        print("test")
        self.dismiss(animated: true, completion: nil)
    }
    
}
