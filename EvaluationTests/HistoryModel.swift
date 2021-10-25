//
//  HistoryModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 24.10.2021.
//

import Foundation


class History{
    static let shared = History()
    var searchHistory = [String]()
}

class Search{
    static let shared = Search()
    var search: String = String()
}
