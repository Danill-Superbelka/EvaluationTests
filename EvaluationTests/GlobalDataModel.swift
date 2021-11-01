//
//  GlobalDataModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 01.11.2021.
//

import Foundation
import UIKit


class History{
    static let shared = History()
    var searchHistory = [String]()
}

class Search{
    static let shared = Search()
    var search: String = String()
}

class StringURL{
    static let shared = StringURL()
    var stringURL: String = String()
}

class AlbumSongsURL{
    static let shared = AlbumSongsURL()
    var stringURL: String = String()
}
