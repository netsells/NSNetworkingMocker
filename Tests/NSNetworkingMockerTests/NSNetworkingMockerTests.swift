//
//  NSNetworkingMockerTests.swift
//  NSNetworkingMockerTests
//
//  Created by Alex on 14/11/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import XCTest
@testable import NSNetworkingMocker

fileprivate struct TestStruct: Codable, Equatable {
    var name: String
}

class NSNetworkingMockerTests: XCTestCase {
    
    
    func testInterceptingRequest() {
        let exp = expectation(description: "Test request intercept")
        
        let testData = TestStruct(name: "Netsells")
        let data = try! JSONEncoder().encode(testData)
        
        let requestURL = URL(string: "https://www.duckduckgo.com")!
        let responseURL = URL(string: "https://www.netsells.co.uk")!
        let config = NetworkingMocker.ResponseConfiguration(
            statusCode: 200,
            data: data,
            delay: 0.1,
            headers: [:],
            httpVersion: .http1_1,
            responseURL: responseURL,
            expectsDataResponse: true)
        
        NetworkingMocker.addMockConfiguration(config, for: requestURL)
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            XCTAssertNil(error)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                XCTFail("Response could not be cast to HTTPURLResponse")
                return
            }
            
            XCTAssertEqual(httpResponse.url, responseURL)
            
            guard let data = data else {
                XCTFail("Data was nil")
                return
            }
            
            let decodedData = try! JSONDecoder().decode(TestStruct.self, from: data)
            
            XCTAssertEqual(testData, decodedData)
            
            exp.fulfill()
            
            }.resume()
        
        wait(for: [exp], timeout: 0.3)
    }
    
    
    func testFailedRequest() {
        let exp = expectation(description: "Test request intercept fail")
        
        let testData = TestStruct(name: "Netsells")
        let data = try! JSONEncoder().encode(testData)
        
        let requestURL = URL(string: "https://www.duckduckgo.com")!
        let responseURL = URL(string: "https://www.netsells.co.uk")!
        let _ = NetworkingMocker.ResponseConfiguration(
            statusCode: 200,
            data: data,
            delay: 0.1,
            headers: [:],
            httpVersion: .http1_1,
            responseURL: responseURL,
            expectsDataResponse: true)
        
        /** The following line of code being commented out will cause the test to fail as MockURLProtocol
        * will only assert that it can be used for the session if the request URL is in the mocks dictionary.
        * Now the actual request to DuckDuckGo will take place.
        */
        
        // NetworkingMocker.addMockConfiguration(config, for: requestURL)
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertNotNil(data)
            
            let decodedData = try? JSONDecoder().decode(TestStruct.self, from: data!)

            XCTAssertNil(decodedData)

            exp.fulfill()
            
            }.resume()
        
        wait(for: [exp], timeout: 10)
    }
    
}
