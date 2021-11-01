//
//  AlbumViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 31.10.2021.
//

import UIKit
import Nuke

class AlbumView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
   

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var albumViewModel: AlbumViewModel?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.keyboardDismissMode = .onDrag
    }
    
    func callToViewModelForUIUpdate(){
        self.albumViewModel = AlbumViewModel()
        self.albumViewModel!.bindAlbumViewModel = {
            self.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if text != ""{
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {[weak self]_ in
                StringURL.shared.stringURL = text ?? " "
                self!.callToViewModelForUIUpdate()
            })
        }
    }
    
    
//MARK: Конфигурация CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albumViewModel?.albums.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albumViewModel?.albums[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.configurateCell(album: album!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albumViewModel?.albums[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVc.album = album
        
        self.present(detailVc,animated: true)
        
    }
}

//MARK: Конфигурация ячеек
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumName: UILabel!
    
    func configurateCell(album: Album.Album){
        if let  stringURL = URL(string:album.artworkUrl100 ?? " "){
            Nuke.loadImage(with: stringURL, into: albumImage)
        } else { albumImage.image = UIImage(systemName: "music.note.list")}
        albumName.text = album.collectionName
    }
}
