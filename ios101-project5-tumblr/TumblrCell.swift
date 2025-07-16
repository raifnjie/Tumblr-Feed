//
//  TumblrCell.swift
//  ios101-project5-tumblr
//
//  Created by Raif Njie on 7/15/25.
//

import UIKit

class TumblrCell: UITableViewCell {
    
    //Create Image view and labels outlets
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
