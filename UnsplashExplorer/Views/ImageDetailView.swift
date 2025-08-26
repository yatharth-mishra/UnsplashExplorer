//
//  ImageDetailView.swift
//  Unsplash Explorer SwiftUI
//
//  Created by Yatharth Mishra on 26/08/25.
//

import SwiftUI

struct ImageDetailView: View {
    @EnvironmentObject var viewModel: UnsplashViewModel
    let image: UnsplashImage
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.urls.full)) { img in
                img.resizable()
                   .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Photographer: \(image.user.name)")
                    .font(.headline)
                Text("Likes: \(image.likes)")
                    .font(.subheadline)
                Text("Description: \(image.description ?? image.alt_description ?? "N/A")")
                    .font(.body)
            }
            .padding()
            
            HStack {
                Button(action: { viewModel.toggleFavourite(image: image) }) {
                    Label(viewModel.isFavourite(image: image) ? "Unfavourite" : "Favourite", systemImage: viewModel.isFavourite(image: image) ? "heart.fill" : "heart")
                }
                
                Spacer()
                
                Button(action: {
                    shareImage(urlString: image.urls.full)
                }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            .padding()
        }
        .navigationTitle("Image Details")
    }
    
    func shareImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true)
    }
}
