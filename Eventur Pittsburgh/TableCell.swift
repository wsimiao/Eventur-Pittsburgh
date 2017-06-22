//
//  TableCell.swift
//  Eventur Pittsburgh
//
//  Created by Simiao on 4/20/16.
//  Copyright © 2016 Yu. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var imageCustomCell: UIImageView!
    
    @IBOutlet weak var titleCustomCell: UILabel!
    
    @IBOutlet weak var subtitleCustomCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
