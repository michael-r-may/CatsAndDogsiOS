//
//  Created by Developer on 2017/03/26.
//
//  Note: this is copied straight from the backend service

import Foundation

public extension TimeZone {
    static var Polish = TimeZone(identifier: "Europe/Warsaw")
    static var California = TimeZone(identifier: "US/Pacific")
}

public extension Locale {
    static var Polish = Locale(identifier: "pl_PL")
    static var US = Locale(identifier: "en_US")
}

public class RFC3339DateFormatter: DateFormatter {
    static var RFC3339DateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    init(locale: Locale, timezone: TimeZone) {
        super.init()
        
        self.locale = locale
        self.dateFormat = RFC3339DateFormatter.RFC3339DateFormat
        self.timeZone = timezone
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
