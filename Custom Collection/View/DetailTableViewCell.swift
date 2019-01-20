//
//  DetailTableViewCell.swift
//  Custom Collection
//
//  Created by Wang, Zewen on 2019-01-18.
//  Copyright © 2019 Wang, Zewen. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var inventoryVariants: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var publishTime: UILabel!
    
    @IBOutlet weak var productID: UILabel!
    @IBOutlet weak var vendors: UILabel!
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var bodyHtml: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
