//
//  MealTableViewController.swift
//  MealTrack
//
//  Created by 邵名浦 on 2019/2/19.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

private let mealArrayKey = "MEAL_ARRAY_KEY"

struct Meal: Codable {
    var mealName: String
    var mealType: String
    var date: String
    var imagePath: String
}

class MealTableViewController: UITableViewController {
    
    // MARK: Elements declaration
    var mealArray = [Meal]()

    // MARK: View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Add button action
    @IBAction func handleAddButton(_ sender: UIBarButtonItem) {
        // Instantiate View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as? ModalViewController else {
            print("Error instantiating ActionViewController" )
            return
        }
        
        // Define a closure to be called in ActionViewController,
        // which will use the elementArray transported from this controller
        vc.didSaveElement = { [weak self] meal in
            self?.mealArray.append(meal)
            
            // Resave element array into User defaults.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self?.mealArray), forKey: mealArrayKey)
            
            self?.tableView.reloadData()
        }
        
        // Present view controller.
        present(vc, animated: true, completion: nil)
    }

    // MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (mealArray.count < 1) {
            setEmptyView(title: "NO MEALS TRACKED YET", message: "🍕🧀🥕🌽🍔🥗🥬🍙🍺")
        } else {
            restore()
        }
        
        return mealArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get cell data
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealTableViewCell
        let mealElement = mealArray[indexPath.row]
        
        // get image data of meal element
        let mealImage = getImage(imageName: mealElement.imagePath)
        
        // set cell
        cell.nameLabel.text = mealElement.mealName
        cell.typeLabel.text = mealElement.mealType
        cell.timeLabel.text = mealElement.date
        cell.mealImage.image = UIImage(contentsOfFile: mealImage)
        
        // styling
        if (indexPath.row % 2) == 0 {
            cell.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        } else {
            cell.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            // to delete row in data source
            self.mealArray.remove(at: indexPath.row)
            // to delete row in tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            success(true)
        })
        
        closeAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    // MARK: Helper functions
    // handle image fetching
    func getImage(imageName: String) -> String {
        // create instance of FileManager
        let fileManager = FileManager.default
        
        // get the file system image path and return it
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        if (fileManager.fileExists(atPath: imagePath)) {
            return imagePath
        } else {
            return "default"
        }
    }
    
    // handle empty table view
    // credit: https://medium.com/@mtssonmez/handle-empty-tableview-in-swift-4-ios-11-23635d108409
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.tableView.center.x, y: self.tableView.center.y, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.tableView.backgroundView = emptyView
        self.tableView.separatorStyle = .none
    }
    func restore() {
        self.tableView.backgroundView = nil
        self.tableView.separatorStyle = .singleLine
    }
    
    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
