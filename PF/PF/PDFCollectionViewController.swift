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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let smallPDFDocumentName = items[indexPath.row]
        showDocument(document(smallPDFDocumentName))
    }
    
    //MARK: - PDF Operation
    fileprivate func document(_ name: String) -> PDFDocument {
        guard let documentURL = Bundle.main.url(forResource: name, withExtension: "pdf") else {
            fatalError("File could not be found")
        }
        return PDFDocument(fileURL: documentURL)
    }
    
    fileprivate func showDocument(_ document: PDFDocument) {
        let storyboard = UIStoryboard(name: "PDFReader", bundle: Bundle(for: PDFViewController.self))
        let controller = storyboard.instantiateInitialViewController() as! PDFViewController
        controller.document = document
        controller.title = document.fileName
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
