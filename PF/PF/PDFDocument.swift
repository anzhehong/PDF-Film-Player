//
//  PDFDocument.swift
//  PDFReader
//
//  Created by ALUA KINZHEBAYEVA on 4/19/15.
//  Copyright (c) 2015 AK. All rights reserved.
//

import CoreGraphics
import UIKit

/// PDF Document on the system to be interacted with
public struct PDFDocument {
    /// Number of pages document contains
    public let pageCount: Int
    
    /// Name of the file stored in the file system
    public let fileName: String
    
    let fileURL: URL
    let coreDocument: CGPDFDocument
    
    /**
     Returns a newly initialized document which is located on the file system.
     
     - parameter fileURL: the file URL where the `.pdf` document exists on the file system
     
     - returns: A newly initialized `PDFDocument`.
     */
    public init(fileURL: URL) {
        self.fileURL = fileURL
        let fileName = fileURL.lastPathComponent
        self.fileName = fileName
        
        guard let coreDocument = CGPDFDocument(fileURL as CFURL) else { fatalError() }
        self.coreDocument = coreDocument
        pageCount = coreDocument.numberOfPages
        
        for pageNumber in 1...pageCount {
            let backgroundImage = self.imageFromPDFPage(pageNumber)
            PDFViewController.images.setObject(backgroundImage, forKey: pageNumber as AnyObject)
        }
    }
    
    func allPageImages() -> [UIImage] {
        return (0..<pageCount).flatMap({ getPDFPageImage($0 + 1) })
    }
    
    func getPDFPageImage(_ pageNumber: Int) -> UIImage {
        if let image = PDFViewController.images.object(forKey: pageNumber as AnyObject) as? UIImage {
            return image
        } else {
            let image = self.imageFromPDFPage(pageNumber)
            PDFViewController.images.setObject(image, forKey: pageNumber as AnyObject)
            return image
        }
    }
    
    fileprivate func imageFromPDFPage(_ pageNumber: Int) -> UIImage {
        let page = coreDocument.page(at: pageNumber)
        // Determine the size of the PDF page.
        var pageRect = page!.getBoxRect(CGPDFBox.mediaBox)
        let scalingConstant: CGFloat = 240
        let pdfScale = min(scalingConstant/pageRect.size.width, scalingConstant/pageRect.size.height)
        pageRect.size = CGSize(width: pageRect.size.width * pdfScale, height: pageRect.size.height * pdfScale)
        
        /*
         Create a low resolution image representation of the PDF page to display before the TiledPDFView renders its content.
         */
        UIGraphicsBeginImageContextWithOptions(pageRect.size, true, 1.0)
        let context = UIGraphicsGetCurrentContext()
        
        // First fill the background with white.
        context!.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        context!.fill(pageRect)
        
        context!.saveGState()
        // Flip the context so that the PDF page is rendered right side up.
        context!.translateBy(x: 0.0, y: pageRect.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        // Scale the context so that the PDF page is rendered at the correct size for the zoom level.
        context!.scaleBy(x: pdfScale, y: pdfScale)
        context!.drawPDFPage(page!)
        context!.restoreGState()
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return backgroundImage!
    }
}
