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
    let url = URL(string: "https://catsanddogs-kotlin-bff.herokuapp.com/schedule.json?from=2017-05-08T12:00:00-02:00")
    let session = URLSession(configuration: .default)

    private func downloadSchedule(completion: @escaping (Data?)->()) {
        session.dataTask(with: url!) { (data, _, _) in completion(data) }.resume()
    }
    
    func allItems(completion: @escaping ([Item])->()){
        self.downloadSchedule() { jsonData in
            let items = jsonData?.jsonArray?.items ?? []
            
            completion(items)
        }
    }
}
