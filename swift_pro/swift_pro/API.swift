//
//  API.swift
//  swift_pro
//
//  Created by Daniel on 23/01/2022.
//

import Foundation

final class API{
    
    static let shared = API()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://api.spaceflightnewsapi.net/v3/articles?_limit=10")
    }
    
    private init(){
        
    }
    
    public func getStories(completion: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode([Article].self, from: data)
                    
                    print("Artigos: \(result.count)")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
}

struct Article: Codable {
  let id: Int
  let title: String
  let imageUrl: String
  let newsSite: String
  let publishedAt: String
}
