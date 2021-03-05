//
//  NewsViewModel.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import Foundation


//Controller Structs

struct NewsTableModel {
   
//    let newsList: [News]
//
//    func numberOfRowsInSection() -> Int {
//        return self.newsList.count
//    }
//
//    func newsAtIndexPath(_ index: Int) -> NewsDetailModel {
//        let news = self.newsList[index]
//        return NewsDetailModel(news: news)
//    }
    
    var title: String
    var id: Int
    var imageURL: String
    
    
}

//struct NewsDetailModel {
//    let news: News
//
//    var title: String {
//        return self.news.title
//    }
//
//    var imageUrl: String {
//        return self.news.imageUrl
//    }
//
//    var id: Int {
//        return self.news.id
//    }
//}
