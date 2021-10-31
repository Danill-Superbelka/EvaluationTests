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
    
    func decodingAlbum<T:Decodable>(stringURL: String, response: @escaping(T?, Error?) -> Void) {
        APIService.shared.getJSON(stringURL: stringURL){ result in
            
            switch result {
            case .success(let data):
                do {
                    let decodingData = try JSONDecoder().decode(T.self, from: data)
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
    
//    func decodingSongs(stringURL: String, response: @escaping(SongsModel?, Error?) -> Void) {
//        APIService.shared.getJSON(stringURL: stringURL){ result in
//
//            switch result {
//            case .success(let data):
//                do {
//                    let songs = try JSONDecoder().decode(SongsModel.self, from: data)
//                    response(songs, nil)
//                } catch let jsonError {
//                    print("Ошибка декодирования \(jsonError)")
//
//                }
//            case .failure(let error):
//                print("Ошибка декодирования данных \(error.localizedDescription)")
//                response(nil, error)
//            }
//
//        }
//    }
}
