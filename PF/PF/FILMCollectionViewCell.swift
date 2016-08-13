//
//  FILMCollectionViewCell.swift
//  PF
//
//  Created by FOWAFOLO on 16/8/13.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class FILMCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        if let img = UIImage(named: "film") {
            self.backgroundImg.image = img
        } else {
            self.backgroundImg.backgroundColor = UIColor.lightGrayColor()
        }
        self.layer.cornerRadius = 5
        
        self.titleLabel.text = "film"
    }

}
