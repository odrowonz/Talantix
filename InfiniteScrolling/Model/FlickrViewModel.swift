//
//  FlickrViewModel.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import Foundation
import UIKit
import CoreData

class FlickrViewModel: FeedViewModel {
    static let baseUrl = "https://www.flickr.com/services/rest/"
    static let apiKey = "52344e91e167a08be273a34de65c5510"
    private static let searchParameters = ["api_key": FlickrViewModel.apiKey,
                             "method": "flickr.photos.search",
                             "text": "cars",
                             "privacy_filter": "1",
                             "safe_search": "1",
                             "media": "photos",
                             "per_page": "100",
                             "format": "json",
                             "nojsoncallback": "1",
                             "extras": "url_q,url_c"]
    private static let exifParameters = ["api_key": FlickrViewModel.apiKey,
                             "method": "flickr.photos.getExif",
                             "format": "json",
                             "nojsoncallback": "1"]
    
    private var context: NSManagedObjectContext
    
    private var perPage: Int {
        set {
            DispatchQueue.main.async {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
                
                let statusRowCount: Int
                var obtainedResults: [NSManagedObject]? = nil
                do {
                    let results = try self.context.fetch(fetchRequest)
                    obtainedResults = results as? [NSManagedObject]
                    statusRowCount = obtainedResults?.count ?? 0
                } catch {
                    statusRowCount = 0
                }
                
                if statusRowCount == 0 {
                    let row = NSEntityDescription.insertNewObject(forEntityName: "Status", into: self.context)
                    row.setValue(1, forKey: "totalPagesCount")
                    row.setValue(1, forKey: "currentPage")
                    row.setValue(100, forKey: "perPage")
                } else {
                    let row = obtainedResults?.first
                    row?.setValue(newValue, forKey: "perPage")
                }
                
                do {
                    try self.context.save()
                }
                catch{
                    print("There was an error in saving data")
                }
            }
        }
        get {
            // Obtaining data from model
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
            
            let statusRowCount: Int
            var obtainedResults: [NSManagedObject]? = nil
            do {
                let results = try context.fetch(fetchRequest)
                obtainedResults = results as? [NSManagedObject]
                statusRowCount = obtainedResults?.count ?? 0
            } catch {
                statusRowCount = 0
            }
            
            if statusRowCount == 0 {
                let row = NSEntityDescription.insertNewObject(forEntityName: "Status", into: context)
                row.setValue(1, forKey: "totalPagesCount")
                row.setValue(1, forKey: "currentPage")
                row.setValue(100, forKey: "perPage")
                do {
                    try context.save()
                }
                catch{
                    print("There was an error in saving data")
                }
                return 100
            } else {
                let row = obtainedResults?.first
                return row?.value(forKey: "perPage") as! Int
            }
        }
    }
    
    private var totalPagesCount: Int {
        set {
            DispatchQueue.main.async {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
                
                let statusRowCount: Int
                var obtainedResults: [NSManagedObject]? = nil
                do {
                    let results = try self.context.fetch(fetchRequest)
                    obtainedResults = results as? [NSManagedObject]
                    statusRowCount = obtainedResults?.count ?? 0
                } catch {
                    statusRowCount = 0
                }
                
                if statusRowCount == 0 {
                    let row = NSEntityDescription.insertNewObject(forEntityName: "Status", into: self.context)
                    row.setValue(1, forKey: "totalPagesCount")
                    row.setValue(1, forKey: "currentPage")
                    row.setValue(100, forKey: "perPage")
                } else {
                    let row = obtainedResults?.first
                    row?.setValue(newValue, forKey: "totalPagesCount")
                }
                
                do {
                    try self.context.save()
                }
                catch{
                    print("There was an error in saving data")
                }
            }
        }
        get {
            // Obtaining data from model
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
            
            let statusRowCount: Int
            var obtainedResults: [NSManagedObject]? = nil
            do {
                let results = try context.fetch(fetchRequest)
                obtainedResults = results as? [NSManagedObject]
                statusRowCount = obtainedResults?.count ?? 0
            } catch {
                statusRowCount = 0
            }
            
            if statusRowCount == 0 {
                let row = NSEntityDescription.insertNewObject(forEntityName: "Status", into: context)
                row.setValue(1, forKey: "totalPagesCount")
                row.setValue(1, forKey: "currentPage")
                row.setValue(100, forKey: "perPage")
                do {
                    try context.save()
                }
                catch{
                    print("There was an error in saving data")
                }
                return 1
            } else {
                let row = obtainedResults?.first
                return row?.value(forKey: "totalPagesCount") as! Int
            }
        }
    }
    
    private var currentPage: Int {
        set {
            DispatchQueue.main.async {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
                
                let statusRowCount: Int
                var obtainedResults: [NSManagedObject]? = nil
                do {
                    let results = try self.context.fetch(fetchRequest)
                    obtainedResults = results as? [NSManagedObject]
                    statusRowCount = obtainedResults?.count ?? 0
                } catch {
                    statusRowCount = 0
                }
                
                if statusRowCount == 0 {
                    let row = NSEntityDescription.insertNewObject(forEntityName: "Status", into: self.context)
                    row.setValue(1, forKey: "totalPagesCount")
                    row.setValue(1, forKey: "currentPage")
                    row.setValue(100, forKey: "perPage")
                } else {
                    let row = obtainedResults?.first
                    row?.setValue(newValue, forKey: "currentPage")
                }
                
                do {
                    try self.context.save()
                }
                catch{
                    print("There was an error in saving data")
                }
            }
        }
        get {
            // Obtaining data from model
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
            
            let statusRowCount: Int
            var obtainedResults: [NSManagedObject]? = nil
            do {
                let results = try context.fetch(fetchRequest)
                obtainedResults = results as? [NSManagedObject]
                statusRowCount = obtainedResults?.count ?? 0
            } catch {
                statusRowCount = 0
            }
            
            if statusRowCount == 0 {
                let row = NSEntityDescription.insertNewObject(forEntityName: "Status", into: context)
                row.setValue(1, forKey: "totalPagesCount")
                row.setValue(1, forKey: "currentPage")
                row.setValue(100, forKey: "perPage")
                do {
                    try context.save()
                }
                catch{
                    print("There was an error in saving data")
                }
                return 1
            } else {
                let row = obtainedResults?.first
                return row?.value(forKey: "currentPage") as! Int
            }
        }
    }
    
    private var aGroup = DispatchGroup()
    
    init(context: NSManagedObjectContext) {
        // Obtaining data from model
        self.context = context
        cacheItems()
    }
    
    // Get count of item's array
    func getCount() -> Int {
        return self.items.count
    }
    
    // Get item
    private var items: [Item] = []
    func getItem(_ i: Int) -> Item {
        return items[i]
    }
    
    func cacheItems() {
        self.items.removeAll()
        
        // Obtaining data from model
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")

        do {
            let results = try context.fetch(fetchRequest)
            let obtainedResults = results as! [NSManagedObject]
            for row in obtainedResults {
                items.append(Item(id: row.value(forKey: "id") as! String,
                                  secret: (row.value(forKey: "secret") as! String),
                                  urlSmall: URL(string: row.value(forKey: "urlSmall") as! String)!,
                                  smallImage: UIImage(data: row.value(forKey: "smallImage")! as! Data),
                                  urlBig: URL(string: row.value(forKey: "urlBig") as! String)!,
                                  bigImage: UIImage(data: row.value(forKey: "bigImage")! as! Data),
                                  exif: (row.value(forKey: "exif") as! String),
                                  downloadDate: row.value(forKey: "downloadDate") as! Date))
            }
        } catch {
            //return Item(id: "", secret: "", urlSmall: URL(string: "")!, smallImage: nil, urlBig: URL(string: "")!, bigImage: nil, exif: "", downloadDate: .init())
        }
    }
    
    // Loading and saving list of items
    func getNextPage(_ refresh: @escaping((_ title: String)->Void)) {
        DispatchQueue.global(qos: .utility).async {
            // get current page with item's list
            var searchParams = FlickrViewModel.searchParameters
            searchParams["page"] = String(self.currentPage)
            searchParams["per_page"] = String(self.perPage)
            NetworkModel.shared.sendRequest(FlickrViewModel.baseUrl,
                                            method: "GET",
                                            parameters: searchParams,
                                            headers: [:]) {
                [weak self]
                (searchResult: Result<SearchFormat>) -> Void in
                guard let self = self else { return }
                
                DispatchQueue.global(qos: .utility).async {
                    let responseSearch: SearchFormat
                    switch searchResult {
                    case .failure(let error):
                        refresh("\u{2139} Flickr cars")
                        print(error)
                        return
                    case .success(let resultType):
                        responseSearch = resultType
                    }
                    
                    // count of pages and array of fotos
                    guard let photos = responseSearch.photos,
                          //let page = photos.page,
                          let perPage = photos.perpage,
                          let pages = photos.pages,
                          let photoArr = photos.photo else {
                              // ApiError.invalidModel
                              refresh("\u{2139} Flickr cars")
                              return
                          }
                    //self.currentPage = page // service has no goot counter
                    self.totalPagesCount = pages
                    self.perPage = perPage
                    
                    let photoArrDic = photoArr.compactMap({ $0 })
                    
                    var bufferItems: [Item] = []
                    // let us convert from Photo to Item every element
                    for pic in photoArrDic {
                        // append only items with id and small images
                        if let id = pic.id,
                           let urlSmallStr = pic.urlQ,
                           let urlSmall = URL(string: urlSmallStr),
                           let urlBig = URL(string: pic.urlC ?? urlSmallStr)  {
                            bufferItems.append(Item(id: id,
                                                    secret: pic.secret,
                                                    urlSmall: urlSmall,
                                                    smallImage: nil,
                                                    urlBig: urlBig,
                                                    bigImage: nil,
                                                    exif: nil,
                                                    downloadDate: .init()))
                        }
                    }
                    // We form a group of asynchronous operations for loading images and exif
                    for item in bufferItems {
                        // Big image
                        self.aGroup.enter()
                        NetworkModel.shared.loadImage(imageURL: item.urlBig) {
                            [weak self]
                            loadResult in
                            
                            DispatchQueue.main.async {
                                guard let self = self else { return }
                                
                                defer { self.aGroup.leave() }
                                
                                switch loadResult {
                                case .failure(_):
                                    item.bigImage = nil
                                    return
                                case .success(let resultType):
                                    item.bigImage = resultType
                                }
                            }
                        }
                        // Small image
                        self.aGroup.enter()
                        NetworkModel.shared.loadImage(imageURL: item.urlSmall) {
                            [weak self]
                            loadResult in
                            
                            DispatchQueue.main.async {
                                guard let self = self else { return }
                                
                                defer { self.aGroup.leave() }
                                
                                switch loadResult {
                                case .failure(_):
                                    item.smallImage = nil
                                    return
                                case .success(let resultType):
                                    item.smallImage = resultType
                                }
                            }
                        }
                        // Exif
                        self.aGroup.enter()
                        self.getExif(id: item.id, secret: item.secret) {
                            [weak self]
                            exifResult in
                            
                            DispatchQueue.main.async {
                                guard let self = self else { return }
                                
                                defer { self.aGroup.leave() }
                                
                                switch exifResult {
                                case .failure(_):
                                    item.exif = nil
                                    return
                                case .success(let resultType):
                                    item.exif = "\(resultType)"
                                }
                            }
                        }
                    }
                    // Callback block for the whole group
                    self.aGroup.notify(queue: DispatchQueue.main) {
                        [weak self] in
                        guard let self = self else { return }
                        self.currentPage += 1
                        for item in bufferItems.filter({$0.bigImage != nil && $0.smallImage != nil && $0.exif != nil}) {
                            self.insertItem(item)
                        }
                        refresh("\u{1F197} Flickr cars")
                    }
                }
            }
        }
    }
    
    // Loading and saving an Exif of item
    func getExif(id: String,
                 secret: String?,
                 completion: @escaping (Result<ExifFormat>) -> Void) {
        // prepare parameters of networking request
        var exifParams = FlickrViewModel.exifParameters
        exifParams["photo_id"] = id
        exifParams["secret"] = secret
        
        // networking request exif
        NetworkModel.shared.sendRequest(FlickrViewModel.baseUrl,
                    method: "GET",
                    parameters: exifParams,
                    headers: [:]) {
            (responseExif: Result<ExifFormat>) -> Void in
            completion(responseExif)
            return
        }
    }
    
    func insertItem(_ item: Item) {
        let row = NSEntityDescription.insertNewObject(forEntityName: "Items", into: context)
        row.setValue(item.id, forKey: "id")
        row.setValue(item.secret!, forKey: "secret")
        row.setValue(item.urlSmall.description, forKey: "urlSmall")
        row.setValue(item.smallImage!.pngData(), forKey: "smallImage")
        row.setValue(item.urlBig.description, forKey: "urlBig")
        row.setValue(item.bigImage!.pngData(), forKey: "bigImage")
        row.setValue(item.exif!, forKey: "exif")
        row.setValue(item.downloadDate, forKey: "downloadDate")
        
        do {
            try context.save()
            self.items.append(item)
        }
        catch{
            print("There was an error in saving data")
        }
    }
}

extension FlickrViewModel: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

