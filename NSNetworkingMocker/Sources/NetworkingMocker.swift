//
//  NetworkingMocker.swift
//  NSNetworkingMocker
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import Foundation

class NetworkingMocker {
    
    /// Configuration object for the response returned by MockURLProtocol
    struct ResponseConfiguration {
        
        /// Status code expected in the response - defaults to 200
        var statusCode = 200
        
        /// Data expected in the response
        var data: Data?
        
        /// Delay applied before the response is returned
        var delay: TimeInterval = 0.5
        
        /// Headers expected in the response
        var headers: [String: String]?
        
        var httpVersion = "1.1"
        
        /// URL expected in the response
        var responseURL: URL!
        
        /// Set to false if data needs to equal nil - defaults to true
        var expectsDataResponse = true
        
    }
    
    /// Storage for mocks - They key is the URL given to the URLRequest or URLSessionDataTask
    static var mocks = [URL: ResponseConfiguration]()
    
    static func clearMocks() {
        mocks = [:]
    }
    
    static func addMockConfiguration(_ mock: ResponseConfiguration, for url: URL) {
        mocks[url] = mock
    }
    
    static func getMockConfiguration(for url: URL) -> ResponseConfiguration? {
        return mocks[url]
    }
}
