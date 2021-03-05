//
//  ViewController.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import UIKit
import SDWebImage

class NewsHomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentNew = [NewsTableModel]()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    let url =  URL(string: "http://app.haberler.com/services/haberlercom/2.11/service.asmx/haberler?category=manset&count=35&offset=0&deviceType=1&userId=61ed99e0c09a8664")
    let request = GetRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MainNewsCell", bundle: .main), forCellReuseIdentifier: "newsCell")
        
        DispatchQueue.main.async {
            self.getNews()
            sleep(1)
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
        
      
      
       
    }
    
    func getNews() {
        GetRequests().getNews(url: url!) { (gotNews) in
            if let gotNews = gotNews {
                for i in 0...3 {
                    self.currentNew.append(NewsTableModel(title: gotNews.news[i].title, id: gotNews.news[i].id, imageURL: gotNews.news[i].imageUrl))
                }
                
            }
           
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
  
        print("will", currentNew)
    }
    

//VC Ends Here
}





extension NewsHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNew.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! MainNewsCell
        
        cell.newsTitle.text = currentNew[indexPath.row].title
        cell.newsImage.sd_setImage(with: URL(string: currentNew[indexPath.row].imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
}

//self.directorImage.sd_setImage(with: URL(string: self.imageUrl2 + directorImage), placeholderImage: UIImage(named: "placeholder.png"))
