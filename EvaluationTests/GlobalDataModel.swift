//
//  GlobalDataModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 01.11.2021.
//

import Foundation
import UIKit


// строка запроса получения информации об альбоме
class StringURL{
    static let shared = StringURL()
    var stringURL: String = String()
}

// строка запроса получения списка песен
class AlbumSongsURL{
    static let shared = AlbumSongsURL()
    var stringURL: String = String()
}
