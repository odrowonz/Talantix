//
//  Item.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import Foundation
import UIKit

class Item {
    
    let id: String
    let secret: String?
    let urlSmall: URL
    var smallImage: UIImage?
    let urlBig: URL
    var bigImage: UIImage?
    var exif: String?
    let downloadDate: Date
    
    init(id: String, secret: String?, urlSmall: URL, smallImage: UIImage?, urlBig: URL, bigImage: UIImage?, exif: String?, downloadDate: Date) {
        self.id = id
        self.secret = secret
        self.urlSmall = urlSmall
        self.smallImage = smallImage
        self.urlBig = urlBig
        self.bigImage = bigImage
        self.exif = exif
        self.downloadDate = downloadDate
    }
    /*
    func setSmallImage(_ smallImage: UIImage) {
        self.smallImage = smallImage
    }
    
    func setBigImage(_ bigImage: UIImage) {
        self.bigImage = bigImage
    }
    
    func setExif(_ exif: ExifFormat) {
        self.exif = exif
    }
    */
    /*func cacheImages() {
        UIImageView.cacheImage(self.urlSmall)
        if let url = self.urlBig { UIImageView.cacheImage(url) }
    }*/
}
