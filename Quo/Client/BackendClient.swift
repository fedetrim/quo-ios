//
//  BackendClient.swift
//  Quo
//
//  Created by Federico Trimboli on 28/04/2018.
//

import Foundation

struct BackendClient {
    private init() { }
}

// MARK: - API info
extension BackendClient {
    
    static var baseURL: String {
        #if DEBUG
        return "http://localhost:8080"
        #else
        return "https://quo-backend.vapor.cloud"
        #endif
    }
    
    static let defaultHeaders = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
}

// MARK: - Helpers
extension BackendClient {
    
    static func url(withPath path: String = "", and queryItems: [URLQueryItem]? = nil) -> URL? {
        guard var urlComponents = URLComponents(string: "\(baseURL)/\(path)") else {
            return nil
        }
        
        queryItems.flatMap { urlComponents.queryItems = $0 }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
    
    static func execute<T: Decodable>(_ request: URLRequest, completion: @escaping (T?, Swift.Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            switch (data, response, error) {
            case (_, _, .some(let error)):
                completion(nil, error)
            case (.some(let data), let response as HTTPURLResponse, _) where response.statusCode == 200:
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let response = try decoder.decode(T.self, from: data)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            default:
                completion(nil, Error.unknown)
                break
            }
        }.resume()
    }
    
}

extension BackendClient {
    enum Error: Swift.Error {
        case couldNotFormURL
        case unknown
    }
}
