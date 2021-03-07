//
//  DetailsCell.swift
//  HaberlerNews
//
//  Created by Umut Sever on 6.03.2021.
//

import UIKit

class DetailsCell: UITableViewCell {

   
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var topView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
