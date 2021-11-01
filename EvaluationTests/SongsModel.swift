//
//  SongsModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 24.10.2021.
//

import Foundation

struct Songs: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
