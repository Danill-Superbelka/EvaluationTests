//
//  AlbumInfoModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 23.10.2021.
//

import Foundation

struct AlbumInfo: Codable {
    struct Album: Codable {
        let artistName: String
        let collectionName: String //Название альбома
        let artworkUrl60: String?
        let artworkUrl100: String?
        let trackCount: Int
        let releaseDate: String
        let primaryGenreName: String
        let copyright: String
        let collectionId: Int
        
//        let collectionViewURL: String
    }
    let resultCount: Int
    let results:[Album]
}

struct AlbumVM: Codable {
    let album: AlbumInfo.Album
    
    private static var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d"
        return dateFormatter
    }
    
    var artist: String {
        return album.artistName
    }
    
    var collection: String {
        return album.collectionName
    }
    
    var trackCount: String {
        return String(album.trackCount)
    }
    
    var image60: String{
        return album.artworkUrl60 ?? " "
    }
    
    var image100: String{
        return album.artworkUrl100 ?? " "
    }
    
    
    
}



