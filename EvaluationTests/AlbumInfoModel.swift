//
//  AlbumInfoModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 23.10.2021.
//

import Foundation

struct Album: Codable {
    struct Album: Codable {
        let artistName: String
        let collectionName: String //Название альбома
        let artworkUrl100: String?
        let trackCount: Int
        let releaseDate: String
        let primaryGenreName: String
        let copyright: String
        let collectionId: Int
    }
    let resultCount: Int
    let results:[Album]
}


