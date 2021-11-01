//
//  AlbumModel.swift
//  EvaluationTests
//
//  Created by Даниил  on 31.10.2021.
//

import Foundation

class AlbumViewModel: NSObject {
    
    private var api : DecodingData!
    var bindAlbumViewModel : (() -> ()) = {}
    
    private(set) var albums: [Album.Album]! {
        didSet {
            self.bindAlbumViewModel()
        }
    }
    
    override init() {
        super.init()
        self.api = DecodingData.shared
        callFuncToGetData()
    }
    
    
    func callFuncToGetData() {
        let stringURL = "https://itunes.apple.com/search?term=\(StringURL.shared.stringURL)&entity=album&attribute=albumTerm"
        self.api.decodingAlbum(stringURL:stringURL ) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else {return}
                
                let sorted = albumModel.results.sorted{ first, second in
                    return first.collectionName.compare(second.collectionName) == ComparisonResult.orderedAscending
                }
                
                self?.albums = sorted
            }
        }
    }
}
