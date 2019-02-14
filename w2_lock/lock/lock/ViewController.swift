//
//  ViewController.swift
//  lock
//
//  Created by 邵名浦 on 2019/2/13.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: initial settings
    // btns
    @IBOutlet weak var btn_1: UIButton! {
        didSet { setupBtn(btn_1) }
    }
    @IBOutlet weak var btn_2_1: UIButton! {
        didSet { setupBtn(btn_2_1) }
    }
    @IBOutlet weak var btn_2_2: UIButton! {
        didSet { setupBtn(btn_2_2) }
    }
    @IBOutlet weak var btn_2_3: UIButton! {
        didSet { setupBtn(btn_2_3) }
    }
    @IBOutlet weak var btn_3_1: UIButton! {
        didSet { setupBtn(btn_3_1) }
    }
    @IBOutlet weak var btn_3_2: UIButton! {
        didSet { setupBtn(btn_3_2) }
    }
    @IBOutlet weak var btn_3_3: UIButton! {
        didSet { setupBtn(btn_3_3) }
    }
    @IBOutlet weak var btn_3_4: UIButton! {
        didSet { setupBtn(btn_3_4) }
    }
    @IBOutlet weak var btn_4_1: UIButton! {
        didSet { setupBtn(btn_4_1) }
    }
    @IBOutlet weak var btn_4_2: UIButton! {
        didSet { setupBtn(btn_4_2) }
    }
    @IBOutlet weak var btn_4_3: UIButton! {
        didSet { setupBtn(btn_4_3) }
    }
    @IBOutlet weak var btn_5: UIButton! {
        didSet { setupBtn(btn_5, true) }
    }
    
    // rows
    @IBOutlet weak var row_2: UIStackView! {
        didSet { setupRows(row_2) }
    }
    @IBOutlet weak var row_3: UIStackView! {
        didSet { setupRows(row_3) }
    }
    @IBOutlet weak var row_4: UIStackView! {
        didSet { setupRows(row_4) }
    }
    
    // texts
    @IBOutlet weak var mainTitle: UITextField!
    @IBOutlet weak var subtitle: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    
    
    // MARK: cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    // MARK: actions
    // correct btns
    @IBAction func row_1(_ sender: Any) {
        correctBtn(btn_1, row_2)
    }
    @IBAction func row_2(_ sender: Any) {
        correctBtn(btn_2_3, row_3)
    }
    @IBAction func row_3(_ sender: Any) {
        correctBtn(btn_3_1, row_4)
    }
    @IBAction func row_4(_ sender: Any) {
        btn_4_2.backgroundColor = UIColor.orange
        btn_5.isHidden = false
    }
    @IBAction func row_5(_ sender: Any) {
        btn_5.backgroundColor = UIColor.orange
        subtitle.text = "🔥🔥🔥🔥🔥🔥"
        mainTitle.text = "UNLOCKED"
        resetBtn.isHidden = false
    }
    // wrong btns
    @IBAction func row_2_wrong_1(_ sender: Any) {
        wrongBtn()
    }
    @IBAction func row_2_wrong_2(_ sender: Any) {
        wrongBtn()
    }
    @IBAction func row_3_wrong_2(_ sender: Any) {
        wrongBtn()
    }
    @IBAction func row_3_wrong_3(_ sender: Any) {
        wrongBtn()
    }
    @IBAction func row_3_wrong_4(_ sender: Any) {
        wrongBtn()
    }
    @IBAction func row_4_wrong_1(_ sender: Any) {
        wrongBtn()
    }
    @IBAction func row_4_wrong_3(_ sender: Any) {
        wrongBtn()
    }
    
    // reset
    @IBAction func reset(_ sender: Any) {
        reset()
    }
    
    
    // set global value
    var oddWrong = true
    
    // MARK: helpers
    func setupBtn(_ btn: UIButton, _ hideFirst: Bool = false) {
        btn.layer.cornerRadius = 15
        btn.isHidden = hideFirst ? true : false
    }
    func setupRows(_ row: UIStackView, _ hideFirst: Bool = true) {
        row.isHidden = hideFirst ? true : false
    }
    func correctBtn(_ btn: UIButton, _ nextRow: UIStackView) {
        btn.backgroundColor = UIColor.orange
        nextRow.isHidden = false
        subtitle.text = "✨✨✨✨✨✨"
    }
    func wrongBtn() {
        subtitle.text = oddWrong ? "🤐🤐🤐🤐🤐🤐" : "👻👻👻👻👻👻"
        oddWrong = !oddWrong
    }
    func reset() {
        subtitle.text = "Try tapping the button to unlock"
        mainTitle.text = "LOCKED"
        resetBtn.isHidden = true
        btn_1.backgroundColor = UIColor.blue
        btn_2_3.backgroundColor = UIColor.blue
        btn_3_1.backgroundColor = UIColor.blue
        btn_4_2.backgroundColor = UIColor.blue
        btn_5.backgroundColor = UIColor.blue
    }

}

