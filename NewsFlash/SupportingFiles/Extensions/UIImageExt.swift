//
//  UIImageExt.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

extension UIImageView {
    func loadImage(fromPathURL pathURL: String) {
        UIImage.loadImage(pathURL: pathURL) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

extension UIImage {
    static var imageCache = NSCache<NSString, UIImage>()

    static func loadImage(pathURL: String, completion: @escaping (UIImage?) -> Void) {
//        let baseURL = "https://image.tmdb.org/t/p/"
//        let imgSize = "w500"
        let completeURL = /*baseURL + imgSize + */pathURL
        
        guard let url = URL(string: completeURL) else {
            completion(nil)
            return
        }

        // Show activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Hide activity indicator
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }

            if let error = error {
                print("Error loading image:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }

            if let image = UIImage(data: data) {
                // Cache the loaded image
                imageCache.setObject(image, forKey: completeURL as NSString)
                completion(image)
            } else {
                print("Unable to create image from data.")
                completion(nil)
            }
        }
        task.resume()
    }

    static func clearCache() {
        imageCache.removeAllObjects()
    }
}
