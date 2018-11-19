//
//  NetworkingMocker.swift
//  NSNetworkingMocker
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import Foundation

/// NetworkingMocker provides a way of storing and retrieving mock reponse objects for both MockURLProtocol and your code
public final class NetworkingMocker {
    
    /// Enum used to supply the http version for the ResponseConfiguration
    public enum HTTPVersion: String {
        case http1_0 = "HTTP/1.0"
        case http1_1 = "HTTP/1.1"
        case http2_0 = "HTTP/2.0"
    }
    
    /// Configuration object for the response returned by MockURLProtocol
    public struct ResponseConfiguration {
        
        /// Status code expected in the response - defaults to 200
        public var statusCode = 200
        
        /// Data expected in the response
        public var data: Data?
        
        /// Delay applied before the response is returned
        public var delay: TimeInterval = 0.5
        
        /// Headers expected in the response
        public var headers: [String: String]?
        
        /// HTTP version used to init HTTPURLResponse
        public var httpVersion: HTTPVersion = .http1_1
        
        /// URL expected in the response
        public var responseURL: URL!
        
        /// Set to false if data needs to equal nil - defaults to true
        public var expectsDataResponse = true
        
    }
    
    /// Used to determine if MockURLProtocol needs to be registered with URLProtocol
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
    
    /// Clears the mocks dictionary
    public static func clearMocks() {
        mocks = [:]
    }
    
    /// Adds a mock to the mocks dictionary using the url as the key
    public static func addMockConfiguration(_ mock: ResponseConfiguration, for url: URL) {
        mocks[url] = mock
    }
    
    /// Returns the mock for the url provided. Returns nil if no key matches.
    public static func getMockConfiguration(for url: URL) -> ResponseConfiguration? {
        return mocks[url]
    }
}
