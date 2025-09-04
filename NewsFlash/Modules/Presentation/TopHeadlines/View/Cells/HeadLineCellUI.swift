//
//  HeadLineCellUI.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct HeadLineCellUI: View {
    var data: Article? = nil
    
    var body: some View {
        HStack {
            AsyncImageView(urlString: data?.image,
                           frame: CGSize(width: 125, height: 125))
            Group {
                VStack(alignment: .leading, spacing: 10) {
                    TextView(txtValue: (data?.title ?? "").capitalized,
                             size: 18,
                             weight: .medium,
                             color: .black,
                             lineLimit: 2)
                    
                    TextView(txtValue: (data?.title ?? "").capitalized,
                             size: 14,
                             weight: .regular,
                             color: Color(UIColor(hex: "636363")),
                             lineLimit: 2)

                    HStack(alignment: .center, spacing: 10) {
                        Image("Date_ic")
                            .renderingMode(.original)
                            .background(Color.gray.opacity(0.2))
                            .frame(width: 15, height: 15)
                            
                        TextView(txtValue: (data?.publishedAt?.dateString() ?? "").capitalized,
                                 size: 13,
                                 weight: .regular,
                                 color: Color(UIColor(hex: "858585")),
                                 lineLimit: 1)
                    }

                }
            }
        }
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor(hex: "E0E0E0")), lineWidth: 1)
        )
    }
}

#Preview {
    HeadLineCellUI()
}
