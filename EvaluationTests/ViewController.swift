//
//  ViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 22.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet var albumTableView: UITableView!
    
    
    override func viewDidLoad() {
        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
        self.albumTableView.estimatedRowHeight = 100.0
        
        
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}



