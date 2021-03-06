//
//  NewsDetailVC.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import AudioToolbox


class NewsDetailVC: UIViewController, AVPlayerViewControllerDelegate {
    
    var theNewsDetail = [NewsTableModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(theNewsDetail)
        
        
     
      
    }
    

    
    
    
    func playVideo() {
        let videoURL = URL(string: theNewsDetail[0].videoUrl)
            let player = AVPlayer(url: videoURL!)
            let playervc = AVPlayerViewController()
            playervc.delegate = self
            playervc.player = player
            self.present(playervc, animated: true) {
                playervc.player!.play()
            }
    }

}
