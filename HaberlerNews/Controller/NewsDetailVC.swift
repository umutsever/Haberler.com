//
//  NewsDetailVC.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import UIKit
import AVKit
import AVFoundation
import SDWebImage
import GPVideoPlayer

class NewsDetailVC: UIViewController, AVPlayerViewControllerDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    var theNewsDetail = [NewsTableModel]()
    var newsImage = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "DetailsCell", bundle: .main), forCellReuseIdentifier: "detailsCell")
        tableView.register(UINib(nibName: "NewsTextCell", bundle: .main), forCellReuseIdentifier: "newsText")
        tableView.dataSource = self
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.newsImage.sd_setImage(with: URL(string: self.theNewsDetail[0].imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            self.tableView.reloadData()
        }
    }
    
    
   
    
    //Video Player
    func gPlayer (bound: CGRect, videoView: UIView) {
        if let GPplayer = GPVideoPlayer.initialize(with: bound) {
            GPplayer.isToShowPlaybackControls = true
                 videoView.addSubview(GPplayer)
                  let url1 = URL(string: theNewsDetail[0].videoUrl)!
            GPplayer.loadVideos(with: [url1])
            GPplayer.isToShowPlaybackControls = true
            GPplayer.isMuted = true
            GPplayer.playVideo()
              }
    }
    
    //MARK: Configure landscape mode
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        
        
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            

            
        } else if UIDevice.current.orientation.isPortrait  {
          
        }
        
    }
    
   
    
    //VC Ends Here
}




extension NewsDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theNewsDetail[0].body.count - 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //If first cell contains video, play. Else show picture
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsCell
            cell.selectionStyle = .none
            cell.topTitle.text = theNewsDetail[0].title
            
            if theNewsDetail[0].videoUrl == "" {
                newsImage.frame = cell.topView.bounds
                cell.topView.addSubview(newsImage)
                cell.selectionStyle = .none
                return cell
            } else {
                gPlayer(bound: cell.topView.bounds, videoView: cell.topView)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        //Cells' texts
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

