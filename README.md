#  NSNetworkingMocker

[![Build Status](https://travis-ci.com/netsells/NSNetworkingMocker.svg?branch=master)](https://travis-ci.com/netsells/NSNetworkingMocker)
[![Version](https://img.shields.io/cocoapods/v/NSNetworkingMocker.svg?style=flat)](https://cocoapods.org/pods/NSNetworkingMocker)
[![License](https://img.shields.io/cocoapods/l/NSNetworkingMocker?style=flat)](https://cocoapods.org/pods/NSNetworkingMocker)
[![Platform](https://img.shields.io/cocoapods/p/NSNetworkingMocker?style=flat)](https://cocoapods.org/pods/NSNetworkingMocker)


## Purpose
* To provide an easy way to mock network request with how we use our APIs
* To provide an easy way to mock APIs while early in development

## Set up

### Installation

NSNetworkingMocker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NSNetworkingMocker'
```

MockURLProtocol is registered with URLProtocol as soon as a mock is added to the NetworkingMocker.mocks dictionary. After this has taken place it will be used automaticlly when using URLSession.shared.

To proxy a request when using a custom URLSession configuration you will need to do the following: 

```swift
let config = URLSessionConfiguration.default
config.protocolClasses = [MockURLProtocol.self]
let session = URLSession(configuration: config)

let dataTask = session.dataTask(...
```

If you use Alamofire then you will need to do the following: 

```swift
let configuration = URLSessionConfiguration.default
configuration.protocolClasses = [MockingURLProtocol.self]
let sessionManager = SessionManager(configuration: configuration)
```

## Author

ABTucanae, tucanae@icloud.com

## License

NSNetworkLater is available under the MIT license. See the LICENSE file for more info.
