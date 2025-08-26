//
//  UnsplashViewMode.swift
//  Unsplash Explorer SwiftUI
//
//  Created by Yatharth Mishra on 26/08/25.
//

import SwiftUI

class UnsplashViewModel: ObservableObject {
    @Published var images: [UnsplashImage] = []
    @Published var favourites: [UnsplashImage] = []
    @Published var searchQuery: String = ""
    
    // Add/remove from favourites
    func toggleFavourite(image: UnsplashImage) {
        if let index = favourites.firstIndex(where: { $0.id == image.id }) {
            favourites.remove(at: index) // remove existing
        } else {
            favourites.append(image)      // add new
        }
    }
    
    func isFavourite(image: UnsplashImage) -> Bool {
        favourites.contains(where: { $0.id == image.id })
    }
    
    // Fetch images (same as before)
    func fetchImages() {
        UnsplashAPIService.shared.fetchImages(query: searchQuery) { [weak self] images in
            self?.images = images
        }
    }
}
