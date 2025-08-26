//
//  ActivityLoaderView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

class ActivityLoaderView: UIView {
    private let activityIndicatorView: UIActivityIndicatorView

    override init(frame: CGRect) {
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .black
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        super.init(frame: frame)

        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        activityIndicatorView.startAnimating()
    }

    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
