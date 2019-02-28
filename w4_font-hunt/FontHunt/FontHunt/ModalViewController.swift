//
//  ModalViewController.swift
//  FontHunt
//
//  Created by 邵名浦 on 2019/2/28.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

/*
 
MARK: global variables
 
*/
private let THUMBNAIL_HEIGHT: CGFloat = 80
private var selectedImagePath: String?

/*
 
MARK: view controller
 
*/
class ModalViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // thumbnail image
    let imageView: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "camera.png"), for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
        MARK: subviews
        */
        // navigation bar
        let navBar = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: FOOTER_HEIGHT)
        )
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .white
        
        let navBar_title = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: navBar.frame.width,
            height: navBar.frame.height)
        )
        navBar_title.textAlignment = .center
        navBar_title.text = "Add new font"
        navBar_title.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        navBar.addSubview(navBar_title)
        
        let navBar_return: UIButton = {
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setImage(UIImage(named: "return.png"), for: .normal)
            
            return btn
        }()
        navBar_return.addTarget(self, action: #selector(self.dismissView(_:)), for: .touchUpInside)
        navBar.addSubview(navBar_return)
        
        let navBar_border = UIView(frame: CGRect(
            x: 0,
            y: navBar.frame.height - 0.25,
            width: navBar.frame.width,
            height: 0.5)
        )
        navBar_border.backgroundColor = UIColor(
            red: 0.65,
            green: 0.65,
            blue: 0.65,
            alpha: 1.0
        )
        navBar.addSubview(navBar_border)
        
        // thumbnail image
        let imageViewBorder = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: imageView.frame.width,
            height: 1
        ))
        imageViewBorder.translatesAutoresizingMaskIntoConstraints = false
        imageViewBorder.backgroundColor = UIColor(
            red: 0.65,
            green: 0.65,
            blue: 0.65,
            alpha: 1.0
        )
        imageView.addTarget(self, action: #selector(self.imageViewPressed(_:)), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(imageViewBorder)
//        let imageTappedGesture = UITapGestureRecognizer(target: imageView, action: #selector(self.imageViewPressed(_:)))
//        imageView.addGestureRecognizer(imageTappedGesture)
        
        
        // class choice
        let btn_selectClass: UIButton = {
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("font class type", for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 14)
            btn.setTitleColor(.gray, for: .normal)
            btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            
            return btn
        }()
        let btn_selectClassBorder = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: btn_selectClass.frame.width,
            height: 1
        ))
        btn_selectClassBorder.translatesAutoresizingMaskIntoConstraints = false
        btn_selectClassBorder.backgroundColor = UIColor(
            red: 0.65,
            green: 0.65,
            blue: 0.65,
            alpha: 1.0
        )
        btn_selectClass.addSubview(btn_selectClassBorder)
//        navBar_return.addTarget(self, action: #selector(self.dismissView(_:)), for: .touchUpInside)
        
        // type choice
        let btn_selectType: UIButton = {
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("font style type", for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 14)
            btn.setTitleColor(.gray, for: .normal)
            btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            
            return btn
        }()
        
        // main stack container
        let mainContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            
            return view
        }()
        let mainContainerBorder = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: 1
        ))
        mainContainerBorder.translatesAutoresizingMaskIntoConstraints = false
        mainContainerBorder.backgroundColor = UIColor(
            red: 0.65,
            green: 0.65,
            blue: 0.65,
            alpha: 1.0
        )
        mainContainer.addSubview(mainContainerBorder)
        
        // view container
        let viewContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            
            return view
        }()
        
        // subviews insertions
        self.view.addSubview(navBar)
        mainContainer.addSubview(imageView)
        mainContainer.addSubview(btn_selectClass)
        mainContainer.addSubview(btn_selectType)
        viewContainer.addSubview(mainContainer)
        self.view.addSubview(mainContainer)
        self.view.addSubview(viewContainer)
        
        // constraints
        // __ navBar
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: FOOTER_HEIGHT).isActive = true
        
        navBar_return.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        navBar_return.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        navBar_return.heightAnchor.constraint(equalToConstant: FOOTER_HEIGHT / 2).isActive = true
        navBar_return.widthAnchor.constraint(equalToConstant: FOOTER_HEIGHT / 2).isActive = true
        
        // __ viewContainer
        viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: FOOTER_HEIGHT).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        viewContainer.isUserInteractionEnabled = false
        
        // __ mainContainer
        mainContainer.topAnchor.constraint(equalTo: viewContainer.topAnchor).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        mainContainer.heightAnchor.constraint(equalToConstant: THUMBNAIL_HEIGHT).isActive = true
        mainContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        // __ mainContainerBorder
        mainContainerBorder.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -0.5).isActive = true
        mainContainerBorder.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        mainContainerBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        mainContainerBorder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        // __ imageView
        imageView.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: THUMBNAIL_HEIGHT).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: THUMBNAIL_HEIGHT).isActive = true
        
        // __ imageViewBorder
        imageViewBorder.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        imageViewBorder.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        imageViewBorder.heightAnchor.constraint(equalToConstant: THUMBNAIL_HEIGHT).isActive = true
        imageViewBorder.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        // __ btn_selectClass
        btn_selectClass.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        btn_selectClass.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        btn_selectClass.heightAnchor.constraint(equalToConstant: THUMBNAIL_HEIGHT / 2).isActive = true
        btn_selectClass.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - THUMBNAIL_HEIGHT).isActive = true
        
        // __ btn_selectClassBorder
        btn_selectClassBorder.bottomAnchor.constraint(equalTo: btn_selectClass.bottomAnchor, constant: 1).isActive = true
        btn_selectClassBorder.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        btn_selectClassBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        btn_selectClassBorder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - THUMBNAIL_HEIGHT).isActive = true
        
        // __ btn_selectType
        btn_selectType.topAnchor.constraint(equalTo: btn_selectClassBorder.bottomAnchor).isActive = true
        btn_selectType.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        btn_selectType.heightAnchor.constraint(equalToConstant: THUMBNAIL_HEIGHT / 2).isActive = true
        btn_selectType.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - THUMBNAIL_HEIGHT).isActive = true
    }
    
    /*
    MARK: Functions
    */
    // closure callback defined in TableViewController
    var didSaveElement: ((_ font: Font) -> ())?
    
    /*
    MARK: event listeners
    */
    
    /* dismiss view */
    @objc func dismissView(_ sender: UIButton!) {
        // animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    /* image picker */
    @objc func imageViewPressed(_ sender: UITapGestureRecognizer) {
        // hide the keyboard
//        mealNameText.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        //imagePickerController.sourceType = .camera
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image
        imageView.setImage(selectedImage, for: .normal)
        
        // save image to FileManager
        // use hashValue of selectedImage as imageName
        saveImage(imageName: String(selectedImage.hashValue))
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    func saveImage(imageName: String) {
        // create an instance of the FileManager
        let fileManager = FileManager.default
        
        // get the file system image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        // get the image we just took/selected
        let image = imageView.currentImage!
        
        // get the png data of this image
        let data = image.pngData()
        
        // update global imageName for sending to Meal Struct
        selectedImagePath = imageName
        
        // store the image in document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
