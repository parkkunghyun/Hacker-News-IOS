//
//  NetworkingManager.swift
//  H4XOR News
//
//  Created by 박경현2 on 2022/05/18.
//

import Foundation

class NetworkingManager: ObservableObject {
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    //json형태를 우리에게 맞게 바꾸자
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do{
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                            
                        } catch {
                            print(error)
                        }
                      
                    }
                    
                }
            }
            task.resume()
        }
    }
}
