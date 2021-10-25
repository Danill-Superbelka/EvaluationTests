//
//  AlbumViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 25.10.2021.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
   
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell"
    
    var albums = [AlbumInfo.Album]()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbum(albumName: "test")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.keyboardDismissMode = .onDrag
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let album = "\(Search.shared.search)"
        getAlbum(albumName: album)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self]_ in
                History.shared.searchHistory.append(text!)
                self?.getAlbum(albumName: text!)
                UserDefaults.standard.set(History.shared.searchHistory, forKey: "searchHistory")
                
            })
        }
    }
    
    func getAlbum(albumName: String){
        print("поиск альбома \(albumName)")

       let stringURL = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
       
       DecodingData.shared.decodingAlbum(stringURL: stringURL) { [weak self] albumModel, error in
           
           if error == nil {
               guard let albumModel = albumModel else {return}
               
               let sorted = albumModel.results.sorted {first, second in
                   return first.collectionName.compare(second.collectionName) == ComparisonResult.orderedAscending
               }
               self?.albums = sorted
               self?.collectionView.reloadData()
           }
       }
   }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albums[indexPath.row]
        var cell = UICollectionViewCell()
        if let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumViewCell {
            albumCell.configurateCell(album: album)
            
            cell = albumCell
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let album = albums[indexPath.row]
            detailVC.album = album
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let album = albums[indexPath.row]
            detailVC.album = album
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}



class AlbumViewCell: UICollectionViewCell {
    
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumName: UILabel!
    
    func configurateCell(album: AlbumInfo.Album){
        if let stringURL = album.artworkUrl100 {
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
    }
    
}
