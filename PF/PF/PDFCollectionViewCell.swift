//
//  PDFCollectionViewCell.swift
//  PF
//
//  Created by FOWAFOLO on 16/8/13.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class PDFCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        if let img = UIImage(named: "pdf") {
            self.backgroundImg.image = img
        } else {
            self.backgroundImg.backgroundColor = UIColor.lightGray
        }
        self.layer.cornerRadius = 5
        
        self.titleLabel.text = "pdf"
    }
}
