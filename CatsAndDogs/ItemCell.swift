//
//  Created by Developer on 2017/04/17.
//  Copyright © 2017 Romain Piel. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    static let CellReuseIdentifier = "ItemCell"
    
    @IBOutlet fileprivate var date: UILabel!
    @IBOutlet fileprivate var time: UILabel!
    @IBOutlet fileprivate var title: UILabel!
    @IBOutlet fileprivate var subtitle: UILabel!
}

extension ItemCell {
    func bound(with item: Item) -> ItemCell {
        self.date?.text = item.date
        self.time?.text = item.time
        self.title?.text = item.title
        self.subtitle?.text = item.subtitle
        
        return self
    }
}

