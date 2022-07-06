//
//  UIImageView+LazyLoading.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import UIKit

extension UIImageView {
    func downloadImage(with string: String, contentMode: UIView.ContentMode) {
        guard let url = NSURL(string: string) else { return }
        URLSession.shared.dataTask(with: url as URL, completionHandler: {
            data, _, _ -> Void in
            DispatchQueue.main.async {
                self.contentMode = contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
