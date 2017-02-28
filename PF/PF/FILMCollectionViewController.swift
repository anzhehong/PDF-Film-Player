//
//  FILMCollectionViewController.swift
//  PF
//
//  Created by FOWAFOLO on 16/8/13.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class FILMCollectionViewController: BaseCollectionViewController {

    fileprivate var videoController: KRVideoPlayerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FILM"
        
        items = FileManager.filmItems
        reuseIdentifier = "FILMCOLLECTION"
    }
    
    //MARK: - UICollectionViewController Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filmName = items[indexPath.row]
        playLocalVideo(filmName)
    }
    
    //MARK: - FILM Operation
    
    fileprivate func playLocalVideo(_ name: String) {
        guard let videoURL = Bundle.main.url(forResource: name, withExtension: "mov") else {
            fatalError("File could not be found")
        }
        playViewdeoWithURL(videoURL)
    }
    
    fileprivate func playViewdeoWithURL(_ url: URL) {
        if videoController != nil {
            videoController.showInWindow()
        }else {
            videoController = KRVideoPlayerController(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth*(9.0/16.0)))
            videoController.showInWindow()
        }
        videoController.contentURL = url
    }
}
