//
//  BaseCollectionViewController.swift
//  PF
//
//  Created by FOWAFOLO on 16/8/13.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let titleHeight: CGFloat = 50

    var items: [String]!
    var reuseIdentifier = "PDFCOLLECTION"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  设置 layOut
        let wh = (screenWidth - 35)/2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: wh, height: wh + titleHeight)
        self.collectionView?.collectionViewLayout = layout
    }
    
    //MARK: - UICollectionView Delegate And Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PDFCollectionViewCell {
            cell.titleLabel.text = FileManager.pdfItems[indexPath.row]
            return cell
        }else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FILMCollectionViewCell {
            cell.titleLabel.text = FileManager.filmItems[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    //MARK:UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}
