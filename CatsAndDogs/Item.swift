//
//  Created on 2017/02/08.
//  Copyright © 2017 Romain Piel and Michael May. All rights reserved.
//
//  { title, subtitle, date, time }

import Foundation

struct Item {
    let title: String
    let subtitle: String
    let date: String
    let time: String
}

// from JSON Dictionary to Item

private extension Dictionary  where Key : ExpressibleByStringLiteral {
    var title : String { return self["title"] as? String ?? "<unknown>" }
    var subtitle : String { return self["subtitle"] as? String ?? "<unknown>" }
    var date : String { return self["date"] as? String ?? "<unknown>" }
    var time : String { return self["time"] as? String ?? "<unknown>" }
}

extension Item {
    init?(json: JSONDictionary?) {
        guard let json = json else { return nil }
        
        self.title = json.title
        self.subtitle = json.subtitle
        self.date = json.date
        self.time = json.time
    }
}
