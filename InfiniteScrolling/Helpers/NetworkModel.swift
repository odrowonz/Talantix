//
//  NetworkModel.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 14.02.2021.
//

import Foundation
import UIKit

class NetworkModel {
    static var shared: NetworkModel = {
            let instance = NetworkModel()
            return instance
        }()
    
    private init() {}
    
    // Send request and save response
    func sendRequest<ResultFormat: Decodable>(_ url: String,
                     method: String,
                     parameters: [String: String],
                     headers: [String: String],
                     completion: @escaping (Result<ResultFormat>) -> Void) {
        var components = URLComponents(string: url)!
        // Each element must be URLQueryItem
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        
        for (value, header) in headers {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(ApiError.networkError))
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                completion(.failure(ApiError.networkError))
                return
            }
            
            switch response.statusCode {
            case (200 ..< 300):
                guard let decodedResponse = try? JSONDecoder().decode(ResultFormat.self, from: data) else {
                    completion(.failure( ApiError.invalidModel))
                    return
                }
                completion(.success(decodedResponse))
            case 401:
                completion(.failure( ApiError.unauthorized))
            case 404:
                completion(.failure( ApiError.notFound))
            case (400..<500):
                completion(.failure( ApiError.badRequest))
            case (500..<600):
                completion(.failure( ApiError.internalServer))
            default:
                completion(.failure( ApiError.networkError))
            }
        }.resume()
    }
    
    // Loading and saving an image
    func loadImage(imageURL: URL,
                   completion: @escaping (Result<UIImage>) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try Data(contentsOf: imageURL)
                guard let image = UIImage(data: data) else {
                    completion(.failure(ApiError.notFound))
                    return
                }
                completion(.success(image))
            } catch {
                completion(.failure(ApiError.networkError))
            }
        }
    }
}

extension NetworkModel: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
