//
//  FILMCollectionViewController.swift
//  PF
//
//  Created by FOWAFOLO on 16/8/13.
//  Copyright © 2016年 TAC. All rights reserved.
//

import UIKit

class FILMCollectionViewController: BaseCollectionViewController {

    private var videoController: KRVideoPlayerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FILM"
        
        items = FileManager.filmItems
        reuseIdentifier = "FILMCOLLECTION"
    }
    
    //MARK: - UICollectionViewController Delegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let filmName = items[indexPath.row]
        playLocalVideo(filmName)
    }
    
    //MARK: - FILM Operation
    
    private func playLocalVideo(name: String) {
        guard let videoURL = NSBundle.mainBundle().URLForResource(name, withExtension: "mov") else {
            fatalError("File could not be found")
        }
        playViewdeoWithURL(videoURL)
    }
    
    private func playViewdeoWithURL(url: NSURL) {
        if videoController != nil {
            videoController.showInWindow()
        }else {
            videoController = KRVideoPlayerController(frame: CGRectMake(0, 0, screenWidth, screenWidth*(9.0/16.0)))
            videoController.showInWindow()
        }
        videoController.contentURL = url
    }
}
