//
//  GetRequests.swift
//  HaberlerNews
//
//  Created by Umut Sever on 5.03.2021.
//

import Foundation


class GetRequests {
   

    
    func getNews(url: URL, completion: @escaping (AllNews?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
               let newsArray = try? JSONDecoder().decode(AllNews.self, from: data)
                
                if let newsArray = newsArray {
                    completion(newsArray)
                }

            }

        }.resume()
        
        
        
        
    }
    
  

}
