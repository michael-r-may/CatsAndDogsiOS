//
//  Created on 2017/02/08.
//  Copyright © 2017 Romain Piel and Michael May. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let contentLoader = OnlineContentLoader()
    
    private(set) var items = [Video]()

    @IBOutlet fileprivate weak var videoTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView?.register(VideoEntryCell.self, forCellReuseIdentifier: VideoEntryCell.CellReuseIdentifier)
        
        self.contentLoader.allVideos { [weak self] videos in
            DispatchQueue.main.async {
                self?.items = videos
                self?.videoTableView?.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView
                .dequeueReusableVideoCell(for: indexPath)
                .bound(with: items[indexPath.row])
    }
}

fileprivate extension UITableView {
    func dequeueReusableVideoCell(for indexPath:IndexPath) -> VideoEntryCell {
        return self.dequeueReusableCell(withIdentifier: VideoEntryCell.CellReuseIdentifier, for: indexPath) as! VideoEntryCell
    }
}

class VideoEntryCell : UITableViewCell {
    static let CellReuseIdentifier = "VideoCellReuseIdentifier"

    func bound(with video: Video) -> VideoEntryCell {
        textLabel?.text = video.title
        
        return self
    }
}
