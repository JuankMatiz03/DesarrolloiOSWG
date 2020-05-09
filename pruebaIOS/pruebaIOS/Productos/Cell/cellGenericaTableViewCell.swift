//
//  cellGenericaTableViewCell.swift
//  pruebaIOS
//
//  Created by Camiilo on 07/05/2020.
//  Copyright © 2020 Camiilo. All rights reserved.
//

import UIKit

class cellGenericaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var producNameLabel: UILabel!
    @IBOutlet weak var valProdLabel: UILabel!
    @IBOutlet weak var menosBtn: UIButton!
    @IBOutlet weak var masBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
