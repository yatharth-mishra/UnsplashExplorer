//
//  FavouriteImagesView.swift
//  Unsplash Explorer SwiftUI
//
//  Created by Yatharth Mishra on 26/08/25.
//

import SwiftUI

struct FavouriteImagesView: View {
    @EnvironmentObject var viewModel: UnsplashViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.favourites.isEmpty {
                    Text("No Favourites Yet")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.favourites) { image in
                                NavigationLink(destination: ImageDetailView(image: image)) {
                                    GeometryReader { geo in
                                        AsyncImage(url: URL(string: image.urls.small), transaction: Transaction(animation: .easeIn)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: geo.size.width, height: geo.size.width)
                                            case .success(let img):
                                                img
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: geo.size.width, height: geo.size.width)
                                                    .clipped()
                                                    .cornerRadius(10)
                                                    .transition(.opacity) // fade-in effect
                                            case .failure(_):
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geo.size.width, height: geo.size.width)
                                                    .foregroundColor(.gray)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    }
                                    .frame(height: UIScreen.main.bounds.width / 2 - 24)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favourites")
        }
    }
}
