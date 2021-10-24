//
//  ViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 22.10.2021.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artist: UILabel!
    @IBOutlet var albumTrackCount: UILabel!
    
    func configurateCell(album: AlbumInfo.Album) {
        
        if let stringURL = album.artworkUrl60 {
            APIService.shared.getJSON(stringURL: stringURL) { [weak self] result in
                switch result {
                case.success(let data):
                    let image = UIImage(data: data)
                    self?.albumImage.image = image
                case.failure(let error):
                    print(error)
                    self?.albumImage.image = UIImage(systemName: "music.note.list")
                }
            }
            } else {
                albumImage.image = UIImage(systemName: "music.note.list")
        }
        
        
        albumName.text = album.collectionName
        artist.text = album.artistName
        albumTrackCount.text = String(album.trackCount)
    }
    
    func emptyCell(){
        albumImage.image = UIImage(systemName: "face.smiling")
        albumName.text = "Ничего не найдено"
//        albumTrackCount = nil
//        artist = nil
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var albumTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var albums = [AlbumInfo.Album]()
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
//        self.albumTableView.estimatedRowHeight = 100.0
        
        getAlbum(albumName: "SenseOfHuman")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self]_ in
                self?.getAlbum(albumName: text!)

            })
        }
    }
    
    private func getAlbum(albumName: String){
        let stringURL = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        DecodingData.shared.decodingAlbum(stringURL: stringURL) { [weak self] albumModel, error in
            
            if error == nil {
                guard let albumModel = albumModel else {return}
                
                let sorted = albumModel.results.sorted {first, second in
                    return first.collectionName.compare(second.collectionName) == ComparisonResult.orderedAscending
                }
                self?.albums = sorted
                self?.albumTableView.reloadData()
            }
        }
    }

//MARK: - Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albums.count != 0 {
            return albums.count
        } else { return 1}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumCell
        
        if albums.count != 0 {
            let album = albums[indexPath.row]
            cell.configurateCell(album: album)
        } else {
            cell.emptyCell()
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}



