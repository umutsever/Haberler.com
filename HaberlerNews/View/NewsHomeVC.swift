//
//  ViewController.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import UIKit
import SDWebImage

class NewsHomeVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var currentNews = [NewsTableModel]()
    var selectedNews = [NewsTableModel]()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var firstIndexNumber = 0
    var secondIndexNumber = 3
    
    let url =  URL(string: "http://app.haberler.com/services/haberlercom/2.11/service.asmx/haberler?category=manset&count=35&offset=0&deviceType=1&userId=61ed99e0c09a8664")
    let request = GetRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MainNewsCell", bundle: .main), forCellReuseIdentifier: "newsCell")

        getNews()
        
      
      print("Açıldı")
       
    }
    
    func getNews() {
        self.spinner.startAnimating()
        GetRequests().getNews(url: url!) { (gotNews) in
            
            if let gotNews = gotNews {
                for i in self.firstIndexNumber...self.secondIndexNumber {
                    self.currentNews.append(NewsTableModel(title: gotNews.news[i].title, id: gotNews.news[i].id, imageUrl: gotNews.news[i].imageUrl, spot: gotNews.news[i].spot, videoUrl: gotNews.news[i].videoUrl.replacingOccurrences(of: "/playlist.m3u8", with: ""), body: gotNews.news[i].body))
                  
                
                }
              
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.firstIndexNumber = self.secondIndexNumber + 1
                self.secondIndexNumber = self.firstIndexNumber + 3
        }
      
        }
        self.spinner.stopAnimating()
        
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            getNews()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsToDetails" {
            let secondVC = segue.destination as! NewsDetailVC
            secondVC.theNewsDetail = selectedNews
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteSelection), name: Notification.Name(rawValue: "deleteSelection"), object: nil)
    }
    
    @objc func deleteSelection() {
        selectedNews.removeAll()
    }
    
//VC Ends Here
}





extension NewsHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! MainNewsCell
        cell.selectionStyle = .none
        cell.newsTitle.text = currentNews[indexPath.row].title
        cell.newsImage.sd_setImage(with: URL(string: currentNews[indexPath.row].imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
}

extension NewsHomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNews.removeAll()
        
        selectedNews.append(NewsTableModel(title: currentNews[indexPath.row].title, id: currentNews[indexPath.row].id, imageUrl: currentNews[indexPath.row].imageUrl, spot: currentNews[indexPath.row].spot, videoUrl: currentNews[indexPath.row].videoUrl, body: currentNews[indexPath.row].body))
        
        performSegue(withIdentifier: "newsToDetails", sender: self)
    }
}
