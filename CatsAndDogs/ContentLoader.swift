//
//  Created by Developer on 2017/02/08.
//  Copyright © 2017 Romain Piel. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

class OfflineContentLoader {
    private func jsonDataFromFile() -> Data? {
        var jsonData : Data? = nil
        
        if let jsonContentPath = Bundle.main.path(forResource: "speakers", ofType: "json") {
            jsonData = FileManager().contents(atPath: jsonContentPath)
        }

        return jsonData
    }
    
    private func json() -> JSONDictionary? {
        var json: JSONDictionary? = nil
        
        if let jsonData = self.jsonDataFromFile() {
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

class OnlineContentLoader {
    let session = URLSession(configuration: .default)
    
    private func jsonDataFromURL(completion: @escaping (Data?)->()) {
        let url = URL(string: "https://catsanddogs-swift-server.herokuapp.com/schedule")
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            completion(data)
        }
        
        task.resume()
    }
    
    private func json(completion: @escaping (JSONDictionary?)->()){
        self.jsonDataFromURL() { jsonData in
            var json: JSONDictionary?
            
            if let jsonData = jsonData { json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? JSONDictionary }
            
            completion(json)
        }
    }
    
    func allVideos(completion: @escaping ([Video])->()) {
        self.json() { json in
            if let event = json?["event"] as? JSONDictionary,
                let speakers = event["speakers"] as? [JSONDictionary] {
                let videos = speakers.flatMap { Video(json: $0) }
                
                completion(videos)
            }
        }
    }
}

extension Video {
    init(json: JSONDictionary) {
        self.title = json["name"] as? String ?? "<unknown>"
        self.company = json["company"] as? String ?? "<unknown>"
    }
}
