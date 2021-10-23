//
//  ViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 22.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var albumTableView: UITableView!
    
    var albums = [AlbumInfo.Album]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
        self.albumTableView.estimatedRowHeight = 100.0
        
        getAlbum(albumName: "SenseOfHuman")
    }
    
    private func getAlbum(albumName: String){
        let stringURL = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        DecodingData.shared.decodingAlbum(stringURL: stringURL) { [weak self] albumModel, error in
            
            if error == nil {
                guard let albumModel = albumModel else {
                    return
                }
                
                self?.albums = albumModel.results
                print(self?.albums)

            }
            
        }
        
        
    }

//MARK:: Table View Functions
    
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



