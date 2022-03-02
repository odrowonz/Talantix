//
//  UIImageView+dowloadFromServer.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    static func cacheImage(_ url: URL) {
        if imageCache.object(forKey: NSString(string: url.absoluteString)) != nil {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                return
            }
            
            DispatchQueue.main.async() {
                imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
            }
        }.resume()
    }
    static func cacheImage(_ link: String) {
        guard let url = URL(string: link) else { return }
        cacheImage(url)
    }
    
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, placeHolder: UIImage?, refresh: @escaping(()->Void)) {
        contentMode = mode
        
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async {
                    [weak self] in
                    self?.image = placeHolder
                    refresh()
                }
                return
            }
            
            imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
            
            DispatchQueue.main.async() {
                [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, placeHolder: UIImage?, refresh: @escaping(()->Void)) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode, placeHolder: placeHolder, refresh: refresh)
    }
}
