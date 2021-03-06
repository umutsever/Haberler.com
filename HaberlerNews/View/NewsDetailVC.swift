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
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var theNewsDetail = [NewsTableModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(theNewsDetail[0].videoUrl)
        
        playVideo()
        //        tableView.register(UINib(nibName: "NewsDetailCell", bundle: .main), forCellReuseIdentifier: "newsTopCell")
        //
        //        tableView.dataSource = self
        
    }
    
    
    
    
    
    func playVideo() {
        let videoURL = URL(string: theNewsDetail[0].videoUrl)

        let asset = AVAsset(url: videoURL!)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
     
        playerLayer.videoGravity = .resizeAspect
        self.topView.layer.addSublayer(playerLayer)
        playerLayer.frame = self.topView.bounds
        
        player.play()
        
    }
    
    
   
    
}


//extension NewsDetailVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//
//
//       return cell
//
//    }
//
//
//}
