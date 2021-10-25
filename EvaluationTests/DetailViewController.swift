//
//  DetailViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 24.10.2021.
//

import UIKit

//MARK: Контроллер отображения Деталей альбома


class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let cellReuseIdentifier = "cell"
    var album: AlbumInfo.Album?
    var songsList = [SongsModel.Song]()
    
// Интерфейс storyboard
    @IBOutlet var tableView: UITableView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artist: UILabel!
    @IBOutlet var genar: UILabel!
    @IBOutlet var songs: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var releaseDate: UILabel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        albumName.text = album?.collectionName
        artist.text = album?.artistName
        genar.text = album?.primaryGenreName
        songs.text = "\(album?.trackCount ?? 0)"
        releaseDate.text = setDate(date: album?.releaseDate ?? "неизвестно")
        
        guard let url = album?.artworkUrl100 else {return}
        setImage(stringURL: url)
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
// получение картинки альбома
    private func setImage(stringURL: String?){
        if let url = stringURL {
            APIService.shared.getJSON(stringURL: url) { [weak self] result in
                switch result {
                case.success(let data):
                    let image = UIImage(data: data)
                    self?.image.image = image
                case.failure(let error):
                    print(error)
                    self?.image.image = UIImage(systemName: "music.note.list")
                }
            }
        }else {
            image.image = nil
        }
    }
// получение песен альбома
    private func setSongs(album: AlbumInfo.Album?) {
        guard let album = album else {return}
        let idAlbum = album.collectionId
        let stringURL = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        DecodingData.shared.decodingSongs(stringURL: stringURL) { [weak self] SongsModel, error in
            if error == nil {
                guard let songModel = SongsModel else {return}
                self?.songsList = songModel.results
               // self?.songsTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
//MARK: TableView Configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songsList[indexPath.row]
        print(song)
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(song)"
        
        
        return cell
    }
}
