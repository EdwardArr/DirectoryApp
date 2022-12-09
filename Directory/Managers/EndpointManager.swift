//
//  EndpointService.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/3/22.
//

import Foundation
import UIKit

protocol EndpointProtocol {
    func createURL(urlString:String) -> URL?
    func callEndpoint(url:URL)async throws -> Data
    func decodeResultToEmployees(data:Data) -> [Employee]
    func fetchEmployees(urlString:String)async throws -> [Employee]
    func fetchImage(urlString:String)async throws -> Data?
}
 
struct EndpointManager: EndpointProtocol {
    
    let url_string_employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    
    func createURL(urlString:String) -> URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }
    
    func callEndpoint(url:URL)async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func decodeResultToEmployees(data:Data) -> [Employee] {
        if let decodedResponse = try? JSONDecoder().decode(Employees.self, from: data) {
            let employees = decodedResponse.employees
            return employees
        }
        // No response decoded return empty list.
        return []
    }
    
    // Used parameter "urlString" instead of hardcoding to test any string.
    func fetchEmployees(urlString:String)async throws -> [Employee] {
        if let url = createURL(urlString: urlString) {
            let data = try await callEndpoint(url: url)
            let employees = decodeResultToEmployees(data: data)
            return employees
        }
        // Invalid url return empty list.
        return []
    }

    func fetchImage(urlString: String) async throws -> Data? {
        if let url = createURL(urlString: urlString) {
            let data = try await callEndpoint(url: url)
            return data
        }
        return nil
    }
}

extension EndpointManager {
    enum EndpointError: Error {
        case invalidURL
    }
}

class ImageCache {
    
    typealias CacheType = NSCache<NSString, NSData>
    
    static let shared = ImageCache()
    
    private init() {}
    
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024 // ~50MB
        return cache
    }()
    
    func object(forKey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }
    
    func set(object:NSData, forKey key:NSString) {
        cache.setObject(object, forKey: key)
    }
}
