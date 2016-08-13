//
//  PDFCollectionViewController.swift
//  PF
//
//  Created by FOWAFOLO on 16/8/13.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class PDFCollectionViewController: BaseCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PDF"
        
        //TODO: Add PDFs here
            /// the name of PDF file name should be ended with '.pdf'
        items = FileManager.pdfItems
        reuseIdentifier = "PDFCOLLECTION"
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let smallPDFDocumentName = items[indexPath.row]
        showDocument(document(smallPDFDocumentName))
    }
    
    //MARK: - PDF Operation
    private func document(name: String) -> PDFDocument {
        guard let documentURL = NSBundle.mainBundle().URLForResource(name, withExtension: "pdf") else {
            fatalError("File could not be found")
        }
        return PDFDocument(fileURL: documentURL)
    }
    
    private func showDocument(document: PDFDocument) {
        let storyboard = UIStoryboard(name: "PDFReader", bundle: NSBundle(forClass: PDFViewController.self))
        let controller = storyboard.instantiateInitialViewController() as! PDFViewController
        controller.document = document
        controller.title = document.fileName
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
