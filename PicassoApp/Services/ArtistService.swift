//
//  ArtistService.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import Foundation

final class ArtistService {
    static let shared = ArtistService()
    
    let urlString = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
    
    private init() {}
    
    func fetch(completion: @escaping(Result<[Artist], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, request, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let artistList = try JSONDecoder().decode(ArtistList.self, from: data)
                completion(.success(artistList.artists))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        .resume()
    }
}
