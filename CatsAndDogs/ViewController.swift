//
//  Created on 2017/02/08.
//  Copyright © 2017 Romain Piel and Michael May. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // outlets
    @IBOutlet fileprivate var tableView: UITableView!
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    
    // data repository
    let contentLoader = OnlineContentLoader()
    
    // local data copy
    private(set) var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("viewcontroller.title", comment: "")
        
        self.activityIndicator.startAnimating()
        
        self.contentLoader.allItems { [weak self] items in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                strongSelf.items = items
                strongSelf.tableView?.reloadData()
                strongSelf.activityIndicator.stopAnimating()
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView
                .dequeueReusableItemCell(for: indexPath)
                .bound(with: items[indexPath.row])
    }
}

fileprivate extension UITableView {
    func dequeueReusableItemCell(for indexPath:IndexPath) -> ItemCell {
        return self.dequeueReusableCell(withIdentifier: ItemCell.CellReuseIdentifier, for: indexPath) as! ItemCell
    }
}

