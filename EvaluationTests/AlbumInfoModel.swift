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
        let artworkUrl100: String
        let trackCount: Int
        let releaseDate: String
        
//        let collectionViewURL: String
    }
    let resultCount: Int
    let results:[Album]
}


struct AlbomInfoVM {
    let info: AlbumInfo.Album
    
    var album: String {
        return info.collectionName
    }
    
    var artist: String {
        return info.artistName
    }
    
   
}
