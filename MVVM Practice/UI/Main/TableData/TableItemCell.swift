//
//  TableItemCell.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 29/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import UIKit

class TableItemCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // Do nothing
    }
    
    func configureCell(item: TableItem) {
        self.lblTitle.text = item.title
        self.lblSubtitle.text = item.subtitle
    }
    
}
