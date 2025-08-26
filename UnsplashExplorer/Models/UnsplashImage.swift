//
//  UnsplashImage.swift
//  Unsplash Explorer SwiftUI
//
//  Created by Yatharth Mishra on 26/08/25.
//

import Foundation

struct UnsplashImage: Codable, Identifiable {
    let id: String
    let description: String?
    let alt_description: String?
    let urls: ImageURLs
    let likes: Int
    let user: User
    
    struct ImageURLs: Codable {
        let small: String
        let regular: String
        let full: String
    }
    
    struct User: Codable {
        let name: String
    }
}
