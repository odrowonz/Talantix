//
//  ApiError.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 06.03.2021.
//
import UIKit
/*enum SearchResult {
    case success(SearchFormat), failure(Error)
}

enum LoadImageResult {
    case success(UIImage), failure(Error)
}*/

enum Result<ResultFormat> {
    case success(ResultFormat), failure(Error)
}

enum ApiError: String, Error {
    case networkError   = "Network is disconnected" // error of network
    case unauthorized   = "Unauthorized request" // 401 error
    case notFound       = "Not found" // 404 error
    case badRequest     = "Bad request" // another 4xx errors
    case internalServer = "Server error" // 5xx errors
    case invalidModel   = "Corrupted model of response" // illegible response
}
