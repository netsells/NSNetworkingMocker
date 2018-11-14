#  NSNetworking Mocker

## Purpose
### To provide an easy way to mock network request with how we use our APIs
### To provide an easy way to mock APIs while early in development


## Set up

### Essential Steps

For MockURLprotocol to be detected by URLSession it must be registered before use.

```URLProtocol.registerClass(MockURLProtocol.self)```


To proxy a request with MockURLProtocol you will need to do the following: 
```
let config = URLSessionConfiguration.default
config.protocolClasses = [MockURLProtocol.self]
let session = URLSession(configuration: config)

let dataTask = session.dataTask(...
```

