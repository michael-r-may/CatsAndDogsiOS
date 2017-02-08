//
//  ViewController.swift
//  CatsAndDogs
//
//  Created by Wrisk on 31/01/2017.
//  Copyright © 2017 Romain Piel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let contentLoader = ContentLoader()
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    private(set) var items = [Video]()

    @IBOutlet weak var videoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = self.contentLoader.allVideos()
        
        videoTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.bind(items[indexPath.row])
        
        return cell
    }

}

extension UITableViewCell {
    func bind(_ video: Video) {
        textLabel?.text = video.title
    }
}


