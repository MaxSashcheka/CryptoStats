//
//  UIImageView.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

extension UIImageView {
    func imageFromUrl(url: URL) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                self.image = UIImage()
            }
        }.resume()
    }
}

extension UIImage {
    static func from(url: URL) -> UIImage? {
        var image: UIImage?
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                image = UIImage(data: data)
            }
        }.resume()
        
        return image
    }
}
