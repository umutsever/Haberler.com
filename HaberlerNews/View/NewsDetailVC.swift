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
        
        
        
        
        
        tableView.register(UINib(nibName: "DetailsCell", bundle: .main), forCellReuseIdentifier: "detailsCell")
        tableView.register(UINib(nibName: "NewsTextCell", bundle: .main), forCellReuseIdentifier: "newsText")
        tableView.dataSource = self
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteSelection"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.newsImage.sd_setImage(with: URL(string: self.theNewsDetail[0].imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
      
        if UIDevice.current.orientation.isLandscape {
            print("Landscape deyim")
            
            
           
            
        }
        else {
            
           
                
            }
            
            
        
    }
    
    
    func videoPlaying (bound: CGRect, theLayer: UIView, top: Bool) {
        
        
        let videoURL = URL(string: theNewsDetail[0].videoUrl)
        
        let asset = AVAsset(url: videoURL!)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        let controller = AVPlayerViewController()
        controller.player = player
        
        playerLayer.frame = bound
        playerLayer.videoGravity = .resizeAspect
        theLayer.layer.addSublayer(playerLayer)
        
        if top == true {
            
        //AVPlayer object
            self.present(controller, animated: true) {[weak self] in
               DispatchQueue.main.async {
                player.isMuted = true
                 player.play()
               }
        
            }
            
        } else {
            player.isMuted = true
            player.play()
        }
    
    
        
    }

  
  
    //VC Ends Here
}




extension NewsDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theNewsDetail[0].body.count - 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsCell
            cell.selectionStyle = .none
            cell.topTitle.text = theNewsDetail[0].title
            
            if theNewsDetail[0].videoUrl == "" {
                print("BOŞUM")
                newsImage.frame = cell.topView.bounds
                cell.topView.addSubview(newsImage)
                cell.selectionStyle = .none
                return cell
            } else {
                print("Değilim", "Video")
           
                videoPlaying(bound: cell.topView.bounds, theLayer: cell.topView, top: false)
                
                cell.selectionStyle = .none
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsText", for: indexPath) as! NewsTextCell
        
        cell.selectionStyle = .none
        if let pText = theNewsDetail[0].body[indexPath.row].p {
            cell.newsTextLabel.text = pText
        } else if let hText = theNewsDetail[0].body[indexPath.row].h3 {
            cell.newsTextLabel.text = hText.uppercased()
        } else if let image = theNewsDetail[0].body[indexPath.row].image {
            cell.newsTextLabel.text = ""
        }
        
        
        
        
        return cell
    }
    
    
}

