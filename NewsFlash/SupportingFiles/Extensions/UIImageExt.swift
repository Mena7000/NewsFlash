//
//  UIImageExt.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

extension UIImageView {
    func loadImage(fromPathURL pathURL: String, defaultImage: UIImage? = UIImage(systemName: "photo")) {
        // show default immediately
        self.image = defaultImage?.withTintColor(.gray)
        self.tintColor = .gray
        
        UIImage.loadImage(pathURL: pathURL) { image in
            DispatchQueue.main.async {
                self.image = image ?? defaultImage
            }
        }
    }
}

extension UIImage {
    static var imageCache = NSCache<NSString, UIImage>()

    static func loadImage(pathURL: String, completion: @escaping (UIImage?) -> Void) {
        // Check cache first
        if let cachedImage = imageCache.object(forKey: pathURL as NSString) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: pathURL) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image:", error.localizedDescription)
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("No data or failed to decode image.")
                completion(nil)
                return
            }

            // Cache and return
            imageCache.setObject(image, forKey: pathURL as NSString)
            completion(image)
        }
        task.resume()
    }

    static func clearCache() {
        imageCache.removeAllObjects()
    }
}
