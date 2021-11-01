//
//  DecodingData.swift
//  EvaluationTests
//
//  Created by Даниил  on 23.10.2021.
//

import Foundation

//MARK: Декодирование JSON

class DecodingData {
    static let shared = DecodingData()
    
    func decodingAlbum(stringURL: String, response: @escaping(Album?, Error?) -> Void) {
        APIService.shared.getData(stringURL: stringURL){ result in
            
            switch result {
            case .success(let data):
                do {
                    let decodingData = try JSONDecoder().decode(Album.self, from: data)
                    response(decodingData, nil)
                } catch let jsonError {
                    print("Ошибка декодирования \(jsonError)")
                }
            case .failure(let error):
                print("Ошибка декодирования данных \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
    
    func decodingSongs(stringURL: String, response: @escaping(Songs?, Error?) -> Void) {
        APIService.shared.getData(stringURL: stringURL){ result in

            switch result {
            case .success(let data):
                do {
                    let songs = try JSONDecoder().decode(Songs.self, from: data)
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
