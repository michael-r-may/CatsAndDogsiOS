//
//  Created by Developer on 2017/02/08.
//  Copyright © 2017 Romain Piel. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

class ContentLoader {
    private func jsonData() -> Data? {
        var jsonData : Data? = nil
        
        if let jsonContentPath = Bundle.main.path(forResource: "speakers", ofType: "json") {
            jsonData = FileManager().contents(atPath: jsonContentPath)
        }

        return jsonData
    }
    
    private func json() -> JSONDictionary? {
        var json: JSONDictionary? = nil
        
        if let jsonData = self.jsonData() {
            json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? JSONDictionary
        }
        
        return json
    }
    
    func allVideos() -> [Video] {
        let json = self.json()
        
        if let event = json?["event"] as? JSONDictionary, let speakers = event["speakers"] as? [JSONDictionary] {
            return speakers.flatMap { Video(json: $0) }
        }
        
        return []
    }
}


extension Video {
    init(json: JSONDictionary) {
        self.title = json["name"] as? String ?? "<unknown>"
        self.company = json["company"] as? String ?? "<unknown>"
    }
}
