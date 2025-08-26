//
//  ToastView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

class ToastView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(message: String) {
        super.init(frame: .zero)
        setupView()
        messageLabel.text = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        layer.cornerRadius = 10
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])

        // Adjust priority for content hugging and compression resistance
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    func show(in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to position the toast at the bottom
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16), // Adjust left spacing as needed
            trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16), // Adjust right spacing as needed
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16) // Adjust bottom spacing as needed
        ])

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Add constraints for width
        NSLayoutConstraint.activate([
            widthAnchor.constraint(lessThanOrEqualToConstant: 300) // Adjust maximum width as needed
        ])
        
        // Dismiss the toast after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss()
        }
    }

    func dismiss() {
        removeFromSuperview()
    }
}
