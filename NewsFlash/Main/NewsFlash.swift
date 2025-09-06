//
//  NewsFlashApp.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

@main
struct NewsFlash: App {
    @StateObject private var uiState = BaseUIState()

    var body: some Scene {
        WindowGroup {
            TopHeadlineUI()
                .environmentObject(uiState)
        }
    }
}
