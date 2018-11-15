//
//  MockURLProtocol.swift
//  NSNetworkingMocker
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import Foundation

public final class MockURLProtocol: URLProtocol {
    
    public enum MockURLProtocolError: Swift.Error {
        case missingConfiguration(url: String)
        case noDataProvidedWhenExpected(url: String)
    }
    
    /// If the request URL doesn't exist as a key in the mocks dictionary, then MockURLProtocol won't assert that it can handle the request
    class func canHandle(url: URL) -> Bool {
        return NetworkingMocker.mocks.keys.first(where: { $0 == url }) != nil
    }
    
    override public class func canInit(with task: URLSessionTask) -> Bool {
        guard let url = task.currentRequest?.url else { return false }
        return canHandle(url: url)
    }
    
    override public class func canInit(with request: URLRequest) -> Bool {
        guard let url = request.url else { return false }
        return canHandle(url: url)
    }
    
    override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override public class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override public func startLoading() {
        guard
            let url = request.url,
            let mock = NetworkingMocker.getMockConfiguration(for: url),
            let httpResponse = HTTPURLResponse(url: mock.responseURL, statusCode: mock.statusCode, httpVersion: mock.httpVersion.rawValue, headerFields: mock.headers)
            else {
                client?.urlProtocol(self, didFailWithError: MockURLProtocolError.missingConfiguration(url: String(describing: request.url?.absoluteString)))
                return
        }
        
        if mock.expectsDataResponse {
            guard let data = mock.data else {
                client?.urlProtocol(self, didFailWithError: MockURLProtocolError.noDataProvidedWhenExpected(url: String(describing: request.url?.absoluteString)))
                return
            }
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + mock.delay) {
                self.client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocolDidFinishLoading(self)
            }
        } else {
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + mock.delay) {
                self.client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
        
    }
    
    override public func stopLoading() {
        // Nothing to implement here
    }
    
}
