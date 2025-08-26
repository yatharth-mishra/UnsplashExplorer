//
//  ContentView.swift
//  UnsplashExplorer
//
//  Created by Yatharth Mishra on 26/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: UnsplashViewModel

    var body: some View {
        TabView {
            ImageGridView()
                .tabItem {
                    Label("Home", systemImage: "photo")
                }

            FavouriteImagesView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UnsplashViewModel())
}
