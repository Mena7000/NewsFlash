//
//  BaseUIState.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/5/25.
//

import SwiftUI

class BaseUIState: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var toastMessage: String? = nil
    
    func showLoading(_ show: Bool) {
        isLoading = show
    }
    
    func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.toastMessage = nil
        }
    }
}
