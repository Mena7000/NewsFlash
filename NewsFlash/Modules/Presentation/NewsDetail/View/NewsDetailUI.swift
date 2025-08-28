//
//  SwiftUIView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import SwiftUI

struct NewsDetailUI: View {
    var data: Article? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: data?.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder while loading
                        Color.gray.opacity(0.2)
                            .overlay(
                                ProgressView()
                            )
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure(_):
                        // Fallback image
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray.opacity(0.6))
                            .padding()
                            .frame(maxWidth: .infinity)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .cornerRadius(15)
                .clipped()
                
                TextView(txtValue: (data?.title ?? "").capitalized,
                         size: 22,
                         weight: .bold,
                         color: .black)
                
                TextView(txtValue: (data?.description ?? "").capitalized,
                         size: 18,
                         weight: .medium,
                         color: Color(UIColor(hex: "636363")))
                
                TextView(txtValue: (data?.content ?? "").capitalized,
                         size: 18,
                         weight: .medium,
                         color: Color(UIColor(hex: "636363")))
                
                if let urlString = data?.url, let url = URL(string: urlString) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Text("Read More")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(UIColor(hex: "0000EE")))
                            .underline()
                    }
                }
                
                HStack(alignment: .center, spacing: 10) {
                    Image("Date_ic")
                        .renderingMode(.original)
                        .background(Color.gray.opacity(0.2))
                        .frame(width: 15, height: 15)
                    
                    TextView(txtValue: (data?.publishedAt?.dateString() ?? "").capitalized,
                             size: 13,
                             weight: .regular,
                             color: Color(UIColor(hex: "858585")))
                }
                
            }
            .padding(.horizontal, 16)
        }
    }
    
    struct TextView: View {
        var txtValue: String
        var size: CGFloat
        var weight: Font.Weight
        var color: Color
        
        var body: some View {
            Text(txtValue)
                .font(.system(size: size, weight: weight))
            //                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(color)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    NewsDetailUI(data: nil)
}
