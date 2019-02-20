//
//  ModalViewController.swift
//  MealTrack
//
//  Created by 邵名浦 on 2019/2/19.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

// note the delegate protocols added
class ModalViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealNameText: UITextField!
    @IBOutlet weak var mealTypeText: UITextField!
    @IBOutlet weak var mealTypePicker: UIPickerView!
    
    // global values
    var mealTypesData = [String]()
    var selectedImagePath: String?
    
    // MARK: View cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide/disable elements
        createButton.isEnabled = false
        mealTypePicker.isHidden = true
        mealTypeText.isEnabled = false
        
        // reset element styles
        mealImage.layer.borderWidth = 1
        mealImage.layer.borderColor = UIColor.gray.cgColor
        mealNameText.layer.borderWidth = 1
        mealNameText.layer.borderColor = UIColor.gray.cgColor
        mealTypeText.layer.borderWidth = 1
        mealTypeText.layer.borderColor = UIColor.gray.cgColor
        
        // config required values
        mealTypesData = ["Breakfast", "Lunch", "Dinner", "Brunch", "Dessert"]
        
        // textfield delegates
        mealNameText.delegate = self
        mealTypeText.delegate = self
        mealTypePicker.delegate = self
        mealTypePicker.dataSource = self
    }
    
    // MARK: Functions
    // Closure callback defined in TableViewController
    var didSaveElement: ((_ meal: Meal) -> ())?
    
    // MARK: Actions
    // textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable createButton
        createButton.isEnabled = false
        
        // hide picker
        mealTypePicker.isHidden = true
    }
    @IBAction func textFieldEditing(_ sender: UITextField) {
        // switch createButton state dependent on textField content
        createButton.isEnabled = mealNameText.text != ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // switch createButton state dependent on textField content
        createButton.isEnabled = textField.text != ""
        
        // hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // meal type picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mealTypesData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mealTypesData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mealTypeText.text = mealTypesData[row]
        mealTypePicker.isHidden = true
    }
    // covering a button on top of textfield to call picker
    @IBAction func mealTypeCoverButton(_ sender: UIButton) {
        mealNameText.resignFirstResponder()
        mealTypeText.resignFirstResponder()
        mealTypePicker.isHidden = false
    }
    
    
    // image selection
    @IBAction func selectImageButton(_ sender: UIButton) {
        // hide the keyboard
        mealNameText.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.sourceType = .camera
        
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
        mealImage.image = selectedImage
        
        // save image to FileManager
        // use hashValue of selectedImage as imageName
        saveImage(imageName: String(selectedImage.hashValue))
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    //-- image saving funciton
    func saveImage(imageName: String) {
        // create an instance of the FileManager
        let fileManager = FileManager.default
        
        // get the file system image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        // get the image we just took/selected
        let image = mealImage.image!
        
        // get the png data of this image
        let data = image.pngData()
        
        // update global imageName for sending to Meal Struct
        selectedImagePath = imageName
        
        // store the image in document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }

    
    // main save and cancel button
    @IBAction func handleCancleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleCreateButton(_ sender: UIButton) {
        // get input data
        let dateString = NSDate().description
        let inputName = mealNameText.text ?? "no value"
        let inputType = mealTypeText.text == "" ? "Just a meal" : mealTypeText.text!
        
        let meal = Meal(mealName: inputName, mealType: inputType, date: dateString, imagePath: selectedImagePath ?? "default-image")
        didSaveElement?(meal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // not working //
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // Disable the Save button while editing.
////        createButton.isEnabled = false
//        print("typing something")
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // Dismisses keyboard when done is pressed.
//        self.view.endEditing(true)
//        return false
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
