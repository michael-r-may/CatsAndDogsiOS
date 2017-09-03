//
//  Created on 2017/02/08.
//  Copyright © 2017 Romain Piel and Michael May. All rights reserved.
//

import Foundation

typealias JSONDictionary = Dictionary<String, Any>

private extension Array where Element : ExpressibleByDictionaryLiteral {
    var items: [Item] { return self.flatMap { Item(json: $0 as? JSONDictionary) } }
}

private extension Data {
    var jsonArray: [JSONDictionary]? { return try! JSONSerialization.jsonObject(with: self, options: []) as? [JSONDictionary] }
}

class OnlineContentLoader {
    private let urlString = "https://catsanddogs-kotlin-bff.herokuapp.com/kotlinconf/schedule.json"
    private let session = URLSession(configuration: .default)

    private func downloadSchedule(completion: @escaping (Data?)->()) {
        let urlRequest: URLRequest? = {
            guard let url = URL(string: self.urlString) else { return nil }
            
            var request = URLRequest(url: url)
            
            request.setValue("Accept-Language", forHTTPHeaderField: NSLocale.current.identifier )
            
            return request
        }()
        
        if let urlRequest = urlRequest {
            session.dataTask(with: urlRequest) { (data, _, _) in completion(data) }.resume()
        }
    }
    
    func allItems(completion: @escaping ([Item])->()){
        self.downloadSchedule() { jsonData in
            let items = jsonData?.jsonArray?.items ?? []
            
            completion(items)
        }
    }
}
