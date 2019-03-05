//
//  MainTableViewCell.swift
//  FontHunt
//
//  Created by 邵名浦 on 2019/2/27.
//  Copyright © 2019 vinceshao. All rights reserved.
//

/*--------- REFERENCE CREDITS ---------*/
//
//
// (1) Programmatically setup cell content: https://softauthor.com/ios-uitableview-programmatically-in-swift/
//
//
/*-------------------------------------*/

import UIKit

class MainTableViewCell: UITableViewCell {
    
    /* REFERENCE CREDIT - (1) */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // cell image
        let image = UIImage(named: "defaultPhoto.png")
        let imageView: UIImageView = {
            let img = UIImageView(image: image)
            img.contentMode = .scaleAspectFill                      // image will never be strecthed vertially or horizontally
            img.translatesAutoresizingMaskIntoConstraints = false   // enable autolayout
            img.clipsToBounds = true
            
            return img
        }()
        
        // cell label
        let dateLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor =  .black
            label.text = "test"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        // adding sub views
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.widthAnchor.constraint(equalToConstant: self.frame.size.width).isActive = true
        
        // constraints - imageView
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        // constraints - dateLabel
        dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
