//
//  UnsplashAPIService.swift
//  Unsplash Explorer SwiftUI
//
//  Created by Yatharth Mishra on 26/08/25.
//

import Foundation

class UnsplashAPIService {
    static let shared = UnsplashAPIService()
    private let apiKey = "GAb_Hz6_JDNmwh2QrSMcHiGD_er2rzku6dYrcJZ2opQ"
    
    func fetchImages(query: String? = nil, completion: @escaping ([UnsplashImage]) -> Void) {
        var urlString = "https://api.unsplash.com/photos?client_id=\(apiKey)"
        if let query = query, !query.isEmpty {
            urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(apiKey)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            var images: [UnsplashImage] = []
            if let query = query, !query.isEmpty {
                if let result = try? JSONDecoder().decode(SearchResult.self, from: data) {
                    images = result.results
                }
            } else {
                images = (try? JSONDecoder().decode([UnsplashImage].self, from: data)) ?? []
            }
            DispatchQueue.main.async {
                completion(images)
            }
        }.resume()
    }
}

struct SearchResult: Codable {
    let results: [UnsplashImage]
}
