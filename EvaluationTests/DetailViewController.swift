//
//  DetailViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 01.11.2021.
//

import UIKit
import Nuke

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artist: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var songsNumber: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var copyright: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    private var detailViewModel: DetailViewModel?
    
    var album: Album.Album?
    var songsAlbum = [Songs.Song]()
    
    let data = [1,2,3,4,5,6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumSongsURL.shared.stringURL = "\(album?.collectionId ?? 0)"
        configurateView()
        callToViewModelForUpdate()
    }
    
    func callToViewModelForUpdate(){
        self.detailViewModel = DetailViewModel()
        self.detailViewModel!.bindDetailViewModel = {
            self.songsAlbum = self.detailViewModel!.songs
            self.tableView.reloadData()
        }
    }
    
    func configurateView(){
        if let imageURL = URL(string: album?.artworkUrl100 ?? " "){
            Nuke.loadImage(with: imageURL, into: albumImage)
        } else {albumImage.image = UIImage(systemName: "music.note.list")}
        albumName.text = album?.collectionName ?? "Error"
        artist.text = album?.artistName ?? "Error"
        genre.text = album?.primaryGenreName ?? "Error"
        songsNumber.text = "\(album?.trackCount ?? 0)"
        date.text = setDate(date: album?.releaseDate ?? "Error")
        copyright.text = album?.copyright
    }
    
// форматирование отображения даты релиза альбома
    private func setDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        
        guard let backDate = dateFormatter.date(from: date) else {return ""}
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backDate)
        return date
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let song = songsAlbum[indexPath.row].trackName
        cell.textLabel?.text = song
        return cell
    }
}
