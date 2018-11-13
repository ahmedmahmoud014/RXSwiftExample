//
//  MainTableViewCell.swift
//  RXSwiftExample
//
//  Created by mac bokk pro on 2018-10-31.
//  Copyright © 2018 mac bokk pro. All rights reserved.
//

import UIKit
class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
