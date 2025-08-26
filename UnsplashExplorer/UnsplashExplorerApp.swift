//
//  UnsplashExplorerApp.swift
//  UnsplashExplorer
//
//  Created by Yatharth Mishra on 26/08/25.
//

import SwiftUI

@main
struct UnsplashExplorerApp: App {
    @StateObject var viewModel = UnsplashViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ImageGridView()
                    .tabItem { Label("Home", systemImage: "photo") }
                
                FavouriteImagesView()
                    .tabItem { Label("Favourites", systemImage: "heart") }
            }
            .environmentObject(viewModel)
        }
    }
}
