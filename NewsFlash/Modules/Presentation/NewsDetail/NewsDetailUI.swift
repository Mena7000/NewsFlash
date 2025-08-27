//
//  SwiftUIView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import SwiftUI

struct NewsDetailUI: View {
    var detailId: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "Date_ic")
                    .resizable()
                    .background(Color.gray.opacity(0.2))
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(15)
                        .clipped()
                    
                TextView(txtValue: "title".capitalized,
                         size: 22,
                         weight: .bold,
                         color: .black)
                
                TextView(txtValue: "description".capitalized,
                         size: 18,
                         weight: .medium,
                         color: Color(UIColor(hex: "636363")))
                
                TextView(txtValue: "content".capitalized,
                         size: 18,
                         weight: .medium,
                         color: Color(UIColor(hex: "636363")))
                
                TextView(txtValue: "Read More",
                         size: 18,
                         weight: .medium,
                         color: Color(UIColor(hex: "0000EE")))
                
                HStack(alignment: .center, spacing: 10) {
                    Image("Date_ic")
                        .renderingMode(.original)
                        .background(Color.gray.opacity(0.2))
                        .frame(width: 15, height: 15)
                        
                    TextView(txtValue: "title".capitalized,
                             size: 13,
                             weight: .regular,
                             color: Color(UIColor(hex: "858585")))
                }

            }
        }
        .padding(.horizontal, 16)
    }
    
    struct TextView: View {
        var txtValue: String
        var size: CGFloat
        var weight: Font.Weight
        var color: Color
        
        var body: some View {
            Text(txtValue)
                .font(.system(size: size, weight: weight))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(color)
                .lineLimit(0)
        }
    }
}

#Preview {
    NewsDetailUI(detailId: 10)
}
