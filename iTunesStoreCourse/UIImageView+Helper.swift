//
//  UIImageView+Helper.swift
//  iTunesStoreCourse
//
//  Created by Amr Hesham on 15/01/2021.
//

import UIKit
extension UIImageView {
    func loadImage(url: URL) {
        let session = URLSession.shared
        // 1
        let downloadTask = session.downloadTask(with: url) { [weak self] (url, response, error) in
            if error == nil, let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                // 4
                DispatchQueue.main.async {
                    self?.image = image
                } }
        }
        downloadTask.resume()

    }
}
