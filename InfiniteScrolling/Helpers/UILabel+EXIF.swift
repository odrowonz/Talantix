//
//  UILabel+EXIF.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 21.02.2021.
//

import Foundation
/*extension UILabel {
    // Loading and saving an Exif of item
    func dowloadFromServer(id: String, secret: String?, model: FeedViewModel, placeHolder: String, refresh: @escaping(()->Void)) {
        var key: NSString
        
        // try get exif from cache
        if let secret = secret {
            key = NSString(string: id + secret)
        } else {
            key = NSString(string: id)
        }

        // maybe it's in cache yet
        if let cacheResult = exifCache.object(forKey: key) {
            guard let exif = cacheResult else { return }
            
            if exif.count > 0 {
                exifLabel.text = exif.reduce("") {
                    return $0 + $1.key + ": " + $1.value + "\n"
                }
            } else {
                exifLabel.text = "Exif no"
            }

            DispatchQueue.main.async() {
                refresh(cacheResult)
            }
            return
        }
        guard let exif = exif else { return }
        if exif.count > 0 {
            exifLabel.text = exif.reduce("") {
                return $0 + $1.key + ": " + $1.value + "\n"
            }
        } else {
            exifLabel.text = "Exif no"
        }
        self.cellRefresh?()
        
        // prepare parameters of networking request
        var exifParams = FlickrViewModel.exifParameters
        exifParams["photo_id"] = id
        exifParams["secret"] = secret
        
        // networking request exif
        NetworkModel.shared.sendRequest(FlickrViewModel.baseUrl,
                    method: "GET",
                    parameters: exifParams,
                    headers: [:]) {
            [weak self] responseExif, errorExif in
            guard let self = self else { return }
            
            if (errorExif == nil) {
                // success response
                if let responseExif = responseExif,
                   let photo = responseExif["photo"] as? Dictionary<String, Any>,
                   let exifArrayAny = photo["exif"] as? Array<Any> {
                    var exifs: [Exif] = []
                    for exifAny in exifArrayAny {
                        if let exifTag = exifAny as? Dictionary<String, Any> {
                            exifs.append(Exif(tagspace: exifTag["tagspace"] as? String,
                                            label: exifTag["label"] as? String,
                                            raw: exifTag["raw"] as? String,
                                            clean: exifTag["clean"] as? String))
                        }
                    }
                    DispatchQueue.main.async() {
                        let photoExif = PhotoExif(exifs)
                        self.exifCache.setObject(photoExif, forKey: key)
                        saving(photoExif)
                    }
                }
            }
        }
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
}
*/
