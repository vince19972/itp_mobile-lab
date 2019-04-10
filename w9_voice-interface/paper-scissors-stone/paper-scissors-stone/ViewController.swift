//
//  ViewController.swift
//  paper-scissors-stone
//
//  Created by 邵名浦 on 2019/4/9.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    let game = Game()
    
    var topContainer: UIView?
    var bottomContainer: UIView?
    var topHand: UILabel?
    var bottomHand: UILabel?
    var topGradientBg: CAGradientLayer?
    var bottomGradientBg: CAGradientLayer?
    var gameWordArray: [String] = []
    var readyToGo = false
    
    enum gameKeyWord: String {
        case paper = "paper"
        case scissors = "scissors"
        case stone = "stone"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestSpeechAuthorization()
        
        /*
        -- MARK: elements creation
        */
        let createElement = ElementCreation()
        
        // containers
        topContainer = createElement.makeMainContainer(parentController: self)
        bottomContainer = createElement.makeMainContainer(parentController: self, isTopHalf: false)
        
        // gradient background
        topGradientBg = createElement.gradientBackground(topContainer!)
            topContainer?.layer.addSublayer(topGradientBg!)
            topGradientBg!.isHidden = true
        bottomGradientBg = createElement.gradientBackground(bottomContainer!)
            bottomContainer?.layer.addSublayer(bottomGradientBg!)
            bottomGradientBg!.isHidden = true
        
        // hands
        topHand = createElement.makeHands(parentContainer: topContainer!)
        bottomHand = createElement.makeHands(parentContainer: bottomContainer!, isTopHalf: false)
        
        // bottom container
        let startBtn = createElement.button(buttonText: "START")
            bottomContainer?.addSubview(startBtn)
            startBtn.centerXAnchor.constraint(equalTo: bottomContainer!.centerXAnchor).isActive = true
            startBtn.centerYAnchor.constraint(equalTo: bottomContainer!.centerYAnchor).isActive = true
            startBtn.addTarget(self, action: #selector(self.startBtnTapped(_:)), for: .touchUpInside)
    }

    /*
    -- MARK: events delegation
    */
    @objc func startBtnTapped(_ sender: UIButton) -> Bool {
        view.endEditing(true)
        
        sender.isHidden = true
        bottomHand?.isHidden = false
        self.recordAndRecognizeSpeech()
        
        return false
    }
    
    /*
    -- MARK: speech recognization
    */
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                var lastString: String = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = bestString.substring(from: indexTo)
                }
                
                // call the action
                let result = self.game.processWord(input: lastString, topHand: self.topHand!, bottomHand: self.bottomHand!)
                switch result {
                    case "even":
                        self.topContainer?.backgroundColor = UIColor(red:0.89, green:0.95, blue:0.99, alpha:1.0)
                        self.bottomContainer?.backgroundColor = UIColor(red:0.99, green:0.89, blue:0.93, alpha:1.0)
                        self.bottomGradientBg?.isHidden = true
                        self.topGradientBg?.isHidden = true
                    case "win":
                        self.bottomGradientBg?.isHidden = false
                        self.topGradientBg?.isHidden = true
                    case "lose":
                        self.bottomGradientBg?.isHidden = true
                        self.topGradientBg?.isHidden = false
                    default:
                        self.topContainer?.backgroundColor = UIColor(red:0.89, green:0.95, blue:0.99, alpha:1.0)
                        self.bottomContainer?.backgroundColor = UIColor(red:0.99, green:0.89, blue:0.93, alpha:1.0)
                        self.bottomGradientBg?.isHidden = true
                        self.topGradientBg?.isHidden = true
                }
                
                
            } else if let error = error {
                self.sendAlert(message: "There has been a speech recognition error.")
                print(error)
            }
            
        })
    }
    
    //MARK: - Check Authorization Status
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("authorized")
                case .denied:
                    print("denied")
                case .restricted:
                    print("restricted")
                case .notDetermined:
                    print("notDetermined")
                @unknown default:
                    return
                }
            }
        }
    }
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

