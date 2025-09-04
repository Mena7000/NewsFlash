//
//  TextView.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct TextView: View {
    var txtValue: String
    var size: CGFloat
    var weight: Font.Weight
    var color: Color
    var lineLimit: Int?
    
    var body: some View {
        Text(txtValue)
            .font(.system(size: size, weight: weight))
//                .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(color)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}
