//
//  NewsStruct.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import Foundation


//GetRequest Structs
struct AllNews: Decodable {
    
    var news: [News]
    
    
}

struct News: Decodable {
    var title: String
    var id: Int
    var imageUrl: String
    
  
    
}




