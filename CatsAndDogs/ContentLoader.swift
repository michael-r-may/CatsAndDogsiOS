//
//  Created on 2017/02/08.
//  Copyright © 2017 Romain Piel and Michael May. All rights reserved.
//

import Foundation

typealias JSONDictionary = Dictionary<String, Any>

private extension Dictionary where Key : ExpressibleByStringLiteral {
    var event : JSONDictionary? { return self["event"] as? JSONDictionary }
    var speakers : [JSONDictionary] { return self["speakers"] as? [JSONDictionary] ?? [] }
}

private extension Array {
    var videos : [Video] { return self.flatMap { Video(json: $0 as? JSONDictionary) } }
}

class OnlineContentLoader {
    let url = URL(string: "https://catsanddogs-swift-server.herokuapp.com/schedule")
    let session = URLSession(configuration: .default)

    private func downloadSchedule(completion: @escaping (Data?)->()) {
        session.dataTask(with: url!) { (data, _, _) in completion(data) }.resume()
    }
    
    private func getSchedule(completion: @escaping (JSONDictionary?)->()){
        self.downloadSchedule() { jsonData in
            var scheduleDictionary: JSONDictionary?
                
            if let jsonData = jsonData { scheduleDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? JSONDictionary }
            
            completion(scheduleDictionary)
        }
    }
    
    func allVideos(completion: @escaping ([Video])->()) {
        self.getSchedule() { schedule in
            let videos = schedule?.event?.speakers.videos ?? []
            
            completion(videos)
        }
    }
}

private extension Dictionary  where Key : ExpressibleByStringLiteral {
    var title : String { return self["name"] as? String ?? "<unknown>" }
    var company : String { return self["company"] as? String ?? "<unknown>" }
}

extension Video {
    init?(json: JSONDictionary?) {
        guard let json = json else { return nil }
        
        self.title = json.title
        self.company = json.company
    }
}
