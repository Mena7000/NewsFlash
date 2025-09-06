//
//  BaseVC.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import SwiftUI

struct BaseView<Content: View>: View {
    @EnvironmentObject var uiState: BaseUIState
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            content

            // Loading overlay
            if uiState.isLoading {
                Color.black.opacity(0.3).ignoresSafeArea()
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }

            // Toast overlay
            if let msg = uiState.toastMessage {
                VStack {
                    Spacer()
                    Toast(message: msg)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: uiState.isLoading)
        .animation(.easeInOut, value: uiState.toastMessage)
    }
}
