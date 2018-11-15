//
//  NetworkingMocker.swift
//  NSNetworkingMocker
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import Foundation

public final class NetworkingMocker {
    
    public enum HTTPVersion: String {
        case http1_0 = "HTTP/1.0"
        case http1_1 = "HTTP/1.1"
        case http2_0 = "HTTP/2.0"
    }
    
    /// Configuration object for the response returned by MockURLProtocol
    public struct ResponseConfiguration {
        
        /// Status code expected in the response - defaults to 200
        var statusCode = 200
        
        /// Data expected in the response
        var data: Data?
        
        /// Delay applied before the response is returned
        var delay: TimeInterval = 0.5
        
        /// Headers expected in the response
        var headers: [String: String]?
        
        /// HTTP version used to init HTTPURLResponse
        var httpVersion: HTTPVersion = .http1_1
        
        /// URL expected in the response
        var responseURL: URL!
        
        /// Set to false if data needs to equal nil - defaults to true
        var expectsDataResponse = true
        
    }
    
    private static var unregistered = true
    
    /// Storage for mocks - They key is the URL given to the URLRequest or URLSessionDataTask
    public static var mocks = [URL: ResponseConfiguration]() {
        didSet {
            // Register the subclass with URLProtocol
            if unregistered {
                URLProtocol.registerClass(MockURLProtocol.self)
                unregistered = false
            }
        }
    }
    
    public static func clearMocks() {
        mocks = [:]
    }
    
    public static func addMockConfiguration(_ mock: ResponseConfiguration, for url: URL) {
        mocks[url] = mock
    }
    
    public static func getMockConfiguration(for url: URL) -> ResponseConfiguration? {
        return mocks[url]
    }
}
