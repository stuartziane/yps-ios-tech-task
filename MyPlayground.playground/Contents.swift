import Cocoa

enum QueryType: String {
    case searchByTitle = "s"
    case searchById = "i"
}

class APIManager {
    
    static let apiHost = "www.ombdapi"
    
    func buildRequestUrl(queryType query: QueryType, with string: String) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APIManager.apiHost
        urlComponents.path = "/"
        
        urlComponents.queryItems = [
            URLQueryItem(name: query.rawValue, value: string),
            URLQueryItem(name: "apikey", value: "b620043c")
        ]
        
        return urlComponents.url
    }
}

let apiManager = APIManager()

let query: QueryType = .searchById
let searchString = "b620043c"

let url = apiManager.buildRequestUrl(queryType: query, with: searchString)
print(url?.absoluteString)
