//
//  BaseVC.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

class BaseVC: UIViewController {
    private var activityLoaderView: ActivityLoaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        activityLoaderView = ActivityLoaderView()
        view.addSubview(activityLoaderView)
        activityLoaderView.isHidden = true

        // Layout constraints if needed
         activityLoaderView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             activityLoaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             activityLoaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
    }

    func activityView(isLoading: Bool) {
        if isLoading {
            activityLoaderView.startAnimating()
            activityLoaderView.isHidden = false
        } else {
            activityLoaderView.stopAnimating()
            activityLoaderView.isHidden = true
        }
    }
    
    func showToaster(msg: String) {
        if !msg.isEmpty {
            let toastView = ToastView(message: msg)
            toastView.show(in: self.view)
        }
    }
}
