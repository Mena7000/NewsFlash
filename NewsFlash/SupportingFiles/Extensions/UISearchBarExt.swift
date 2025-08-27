//
//  UISearchBar.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import UIKit
import Combine

// MARK: - Publisher Extension
extension UISearchBar {
    var textDidChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UISearchTextField.textDidChangeNotification,
            object: self.searchTextField
        )
        .compactMap { ($0.object as? UISearchTextField)?.text }
        .filter { !$0.isEmpty }
        .eraseToAnyPublisher()
    }
}
