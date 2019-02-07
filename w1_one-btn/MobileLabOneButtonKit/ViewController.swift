//
//  ViewController.swift
//  MobileLab1ButtonKit
//
//  Created by Nien Lam on 1/19/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//
//  Description:
//  View controller creating a one button application.

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // EDIT START ////////////////////////////////////////////////////////////////////////////////////////
    
    // Set to 'true' or 'false' to control content sequence.
    // Either flip through content in sequence or randomize.
    let randomize = false
    
    // Set to array size.
    // Make sure all arrays are the same length and matches array size.
    let arraySize = 6
    
    // Background array.
    let bgColorArray = [UIColor(hex: 0xffe100),
                        UIColor(hex: 0x8dc21f),
                        UIColor(hex: 0x5f1985),
                        UIColor(hex: 0xe35c20),
                        UIColor(hex: 0x036eb7),
                        UIColor(hex: 0xda3418)]
    
    // Image name array.
    // Set to image name or set to empty string.
    let imageNameArray = ["88-happy.png",
                          "88-complaining.png",
                          "88-hmm.png",
                          "88-smile.png",
                          "88-umm.png",
                          "88-angry.png"]
    
    // String array for label.
    // Set text or set to empty string.
    let stringArray = ["Happy",
                       "Complaining",
                       "Hmm...",
                       "Smiling",
                       "Umm...",
                       "Angry"]
    
    // MP3 sound file array.
    // Set mp3 file name or set to empty string.
    let soundArray = ["",
                      "",
                      "",
                      "",
                      "",
                      ""]
    
    // EDIT END //////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////

    
    // Connected to storyboard UI elements.
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var initLabel: UILabel!
    
    var player: AVAudioPlayer?

    var currentIndex = -1

    
    // Initial setup function.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial view rendering
        viewRendering()
    }

    // Called when screen is tapped.
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        generateImpactFeedback()
        
        // Tapped screen rendering
        viewRendering(false)
    }
    
    // View rendering depends on is at intial screen or not.
    func viewRendering(_ isInitialScreen: Bool = true) {
        if isInitialScreen {
            view.backgroundColor = UIColor(hex: 0x1eaa39)
            showHideScreens()
        } else {
            showHideScreens(false)
            updateContent()
        }
    }
    
    // Show and hide screens.
    func showHideScreens(_ isInitialScreen: Bool = true) {
        label.isHidden = isInitialScreen ? true : false
        imageView.isHidden = isInitialScreen ? true : false
        initLabel.isHidden = isInitialScreen ? false : true
    }

    // Update content based on array content and current array index.
    func updateContent() {
        // Update content index.,
        nextIndex()

        // Update background color.
        view.backgroundColor = bgColorArray[currentIndex]

        // Update label.
        label.text = stringArray[currentIndex]

        // Update image if string is not empty
        if imageNameArray[currentIndex].isEmpty {
            imageView.image = nil
        } else {
            imageView.image = UIImage(named: imageNameArray[currentIndex])
        }

        // Play sound.
        if !soundArray[currentIndex].isEmpty {
            playSoundMP3(filename: soundArray[currentIndex])
        }
    }

    
    // Either increment index or randomize.
    func nextIndex() {
        if randomize {
            currentIndex = Int(arc4random_uniform(UInt32(arraySize)))
        } else {
            currentIndex = (currentIndex + 1 == arraySize) ? 0 : currentIndex + 1
        }
    }

    // Make the device vibrate.
    func generateImpactFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    // Play a mp3 sound file.
    func playSoundMP3(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
