//
//  CachedImageViewModel.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/5/22.
//

import Foundation
import UIKit

class CachedImageViewModel: ObservableObject {
    
    @Published private(set) var currentState:CurrrentState?
    
    private let endpoint = EndpointManager()
    
    @MainActor
    func load(urlString:String, cache: ImageCache = .shared) async {
        
        self.currentState = .loading
        
        if let data = cache.object(forKey: urlString as NSString){
            self.currentState = .success(data:data)
            return
        }
        do {
            if let data = try await endpoint.fetchImage(urlString: urlString) {
                self.currentState = .success(data: data)
                cache.set(object: data as NSData, forKey: urlString as NSString)
            }
        } catch {
            self.currentState = .failed(error: error)
        }
    }
}

extension CachedImageViewModel {
    enum CurrrentState {
        case loading
        case failed(error:Error)
        case success(data:Data)
    }
}
