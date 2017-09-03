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
            guard var urlComponents = URLComponents(string: self.urlString) else { return nil }
            
            let currentLocale = Locale.US
            let currentTimeZone = TimeZone.California!
            
            let dateFormatter = RFC3339DateFormatter(locale: currentLocale,
                                                     timezone: currentTimeZone)
  
            let dateConferenceStarts = dateFormatter.date(from: "2017-11-02T11:00:00-07:00")
                        
            let fromQuery = URLQueryItem(name: "from", value: dateFormatter.string(for: dateConferenceStarts))
            urlComponents.queryItems = [fromQuery]
            
            if let url = urlComponents.url {
                var request = URLRequest(url: url)
                
                request.setValue("Accept-Language", forHTTPHeaderField: currentLocale.identifier)
                
                return request
            }
            
            return nil
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
