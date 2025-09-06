//
//  ToastView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import SwiftUI

struct Toast: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 4)
            .padding(.bottom, 30)
    }
}
