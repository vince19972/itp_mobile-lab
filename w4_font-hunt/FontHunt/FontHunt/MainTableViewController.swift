//
//  MainTableViewController.swift
//  FontHunt
//
//  Created by 邵名浦 on 2019/2/27.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

/*
 
 MARK: Gloabl vars
 
*/
let IDENTIFIER_CELL = "mainCell"


/*
 
 MARK: TableView starts
 
*/
class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling
        self.tableView.rowHeight =
            UIScreen.main.bounds.width * 1.15           // row height setting
        self.tableView.separatorStyle =
            UITableViewCell.SeparatorStyle.none         // separator style
        self.tableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: FOOTER_HEIGHT,
            right: 0
        )                                               // padding bottom style

        // register cell view
        self.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: IDENTIFIER_CELL)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    /*
     table cell controll
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL, for: indexPath) as! MainTableViewCell
        
        // cell styling
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // data updating
//        cell.imageView.image = UIImage(contentsOfFile: <#T##String#>)
        
        return cell
    }
    
    /*
     header section controll
    */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 48))
        headerView.backgroundColor = .white
        headerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        
        let header_logo = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
        header_logo.textAlignment = .center
        header_logo.text = "Font Hunt"
        header_logo.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        headerView.addSubview(header_logo)
        
        let header_border = UIView(frame: CGRect(x: 0, y: headerView.frame.height - 0.25, width: headerView.frame.width, height: 0.5))
        header_border.backgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        headerView.addSubview(header_border)

        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
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
