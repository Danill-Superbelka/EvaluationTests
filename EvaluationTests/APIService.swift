//
//  APIService.swift
//  EvaluationTests
//
//  Created by Даниил  on 23.10.2021.
//

import Foundation

//MARK: Создание запроса для получения JSON 

class APIService {
    static let shared = APIService()
    
    public enum ApiError: Error {
        case error(_ errorString: String)
    }
    
    public func getData(stringURL: String, completion: @escaping(Result<Data, ApiError>) -> Void ) {
    
        guard let url = URL(string: stringURL) else {
            print("Ошибка получения URL")
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: " "))))
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Ошибка URL сессии, \(error)")
                    completion(.failure(.error("Error: Invalide URL Session")))
                    return
                }
                guard let data = data else {
                    print("Ошибка получения данных")
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
}
