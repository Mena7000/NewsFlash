//
//  Untitled.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct AsyncImageView: View {
    let urlString: String?
    var frame: CGSize?

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: urlString ?? "")) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.2)
                        .overlay(ProgressView())

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray.opacity(0.6))
                        .padding()

                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(width: frame?.width, height: frame?.height)
//            .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .clipped()
        .padding(.horizontal, 16)
    }
}

