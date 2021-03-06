//
//  MainNewsCell.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import UIKit

class MainNewsCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
       
    }
    
}
