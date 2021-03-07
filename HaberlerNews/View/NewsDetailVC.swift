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
import SDWebImage


class NewsDetailVC: UIViewController, AVPlayerViewControllerDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    var theNewsDetail = [NewsTableModel]()
    var newsImage = UIImageView()
    var texts = [String]()
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.newsImage.sd_setImage(with: URL(string: self.theNewsDetail[0].imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            
            
//            for i in self.theNewsDetail[0].body[0...5] {
//                if let pText = i.p {
//                    self.texts.append(pText)
//                } else if let hText = i.h3 {
//                    self.texts.append(hText.uppercased())
//                } else if let image = i.image {
//                    self.texts.append(image)
//                }
//            }
            
            
            self.tableView.reloadData()
        }
        
      
      
       
        print(theNewsDetail[0].body.count, "count")
        
        tableView.register(UINib(nibName: "DetailsCell", bundle: .main), forCellReuseIdentifier: "detailsCell")
        tableView.register(UINib(nibName: "NewsTextCell", bundle: .main), forCellReuseIdentifier: "newsText")
        tableView.dataSource = self
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteSelection"), object: nil)
        
    }
    
    
    
    
//
//    func playVideo() {
//        let videoURL = URL(string: theNewsDetail[0].videoUrl)
//
//        let asset = AVAsset(url: videoURL!)
//          let playerItem = AVPlayerItem(asset: asset)
//          let player = AVPlayer(playerItem: playerItem)
//
//          //3. Create AVPlayerLayer object
//          let playerLayer = AVPlayerLayer(player: player)
//        print(playerLayer.frame, "FRAME")
//        playerLayer.frame = self.topView.bounds
//        playerLayer.videoGravity = .resizeAspect
//
//          //4. Add playerLayer to view's layer
//          self.topView.layer.addSublayer(playerLayer)
//
//          //5. Play Video
//          player.play()
//
//
//
//    }
    
    
}


extension NewsDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theNewsDetail[0].body.count - 1
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsCell
            cell.topTitle.text = theNewsDetail[0].title
            
            if theNewsDetail[0].videoUrl == "" {
                newsImage.frame = cell.topView.bounds
                cell.topView.addSubview(newsImage)
            } else {
                
                let videoURL = URL(string: theNewsDetail[0].videoUrl)

                let asset = AVAsset(url: videoURL!)
                  let playerItem = AVPlayerItem(asset: asset)
                  let player = AVPlayer(playerItem: playerItem)

                  //3. Create AVPlayerLayer object
                  let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = cell.topView.bounds
                playerLayer.videoGravity = .resizeAspect
                  //4. Add playerLayer to view's layer
                cell.topView.layer.addSublayer(playerLayer)
                  //5. Play Video
                  player.play()
                
                return cell
            }
        }
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsText", for: indexPath) as! NewsTextCell
        
        for i in 1...indexPath.row {
            if let pText = theNewsDetail[0].body[indexPath.row].p {
                cell.newsTextLabel.text = pText
            } else if let hText = theNewsDetail[0].body[indexPath.row].h3 {
                cell.newsTextLabel.text = hText.uppercased()
            } else if let image = theNewsDetail[0].body[indexPath.row].image {
                cell.newsTextLabel.text = image
            }
        }
        
       

        return cell
    }

    
}
