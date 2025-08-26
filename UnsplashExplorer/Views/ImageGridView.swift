//
//  ImageGridView.swift
//  Unsplash Explorer SwiftUI
//
//  Created by Yatharth Mishra on 26/08/25.
//

import SwiftUI

struct ImageGridView: View {
    @EnvironmentObject var viewModel: UnsplashViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // 2-column grid
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.images) { image in
                        NavigationLink(destination: ImageDetailView(image: image)) {
                            GeometryReader { geo in
                                AsyncImage(url: URL(string: image.urls.small)) { img in
                                    img
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: geo.size.width)
                                        .clipped()
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: geo.size.width, height: geo.size.width)
                                }
                            }
                            .frame(height: UIScreen.main.bounds.width / 2 - 24)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Unsplash Images")
            .searchable(text: $viewModel.searchQuery)
            .onChange(of: viewModel.searchQuery) { _ in
                viewModel.fetchImages()
            }
            .onAppear {
                viewModel.fetchImages()
            }
        }
    }
}
