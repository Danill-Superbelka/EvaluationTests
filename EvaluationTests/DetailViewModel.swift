//
//  DetailViewModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 01.11.2021.
//

import Foundation

class DetailViewModel: NSObject {
    private var api : DecodingData!
    
    var bindDetailViewModel : (() -> ()) = {}
    
    private(set) var songs: [Song]! {
        didSet {
            self.bindDetailViewModel()
        }
    }
    
    override init() {
        super.init()
        self.api = DecodingData.shared
        callFuncToGetSongs()
    }
    
    func callFuncToGetSongs(){
        let stringURL = "https://itunes.apple.com/lookup?id=\(AlbumSongsURL.shared.stringURL)&entity=song"
        print("Вызов функции \(stringURL)")
        self.api.decodingSongs(stringURL: stringURL) { [weak self] songsModel, error in
            if error == nil {
                guard let songsModel = songsModel else {return}
                self?.songs = songsModel.results
            }
        }
    }
}
