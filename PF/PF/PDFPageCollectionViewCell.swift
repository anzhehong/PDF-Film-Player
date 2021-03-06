//
//  PDFPageCollectionViewCell.swift
//  PDFReader
//
//  Created by Ricardo Nunez on 7/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

import UIKit

protocol PDFPageCollectionViewCellDelegate: class {
    func handleSingleTap(_ cell: PDFPageCollectionViewCell, pdfPageView: PDFPageView)
}

internal final class PDFPageCollectionViewCell: UICollectionViewCell {
    var pageIndex: Int?
    var pageView: PDFPageView? {
        didSet {
            subviews.forEach({ $0.removeFromSuperview() })
            if let pageView = pageView {
                addSubview(pageView)
            }
            
        }
    }
    
    fileprivate weak var pageCollectionViewCellDelegate: PDFPageCollectionViewCellDelegate?
    
    func setup(_ indexPathRow: Int, collectionViewBounds: CGRect, document: PDFDocument, pageCollectionViewCellDelegate: PDFPageCollectionViewCellDelegate?) {
        self.pageCollectionViewCellDelegate = pageCollectionViewCellDelegate
        pageView = PDFPageView(frame: bounds, document: document, pageNumber: indexPathRow, pageViewDelegate: self)
        pageIndex = indexPathRow
    }
}

extension PDFPageCollectionViewCell: PDFPageViewDelegate {
    func handleSingleTap(_ pdfPageView: PDFPageView) {
        pageCollectionViewCellDelegate?.handleSingleTap(self, pdfPageView: pdfPageView)
    }
}
