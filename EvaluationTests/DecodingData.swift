//
//  DecodingData.swift
//  EvaluationTests
//
//  Created by Даниил  on 23.10.2021.
//

import Foundation

class DecodingData {
    static let shared = DecodingData()
    
    func decodingAlbum(stringURL: String, response: @escaping(AlbumInfo?, Error?) -> Void) {
        APIService.shared.getJSON(stringURL: stringURL){ result in
            
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumInfo.self, from: data)
                    response(albums, nil)
                } catch let jsonError {
                    print("Ошибка декодирования \(jsonError)")
                    
                }
            case .failure(let error):
                print("Ошибка декодирования данных \(error.localizedDescription)")
                response(nil, error)
            }
            
        }
    }
    
    func decodingSongs(stringURL: String, response: @escaping(SongsModel?, Error?) -> Void) {
        APIService.shared.getJSON(stringURL: stringURL){ result in
            
            switch result {
            case .success(let data):
                do {
                    let songs = try JSONDecoder().decode(SongsModel.self, from: data)
                    response(songs, nil)
                } catch let jsonError {
                    print("Ошибка декодирования \(jsonError)")
                    
                }
            case .failure(let error):
                print("Ошибка декодирования данных \(error.localizedDescription)")
                response(nil, error)
            }
            
        }
    }
}
