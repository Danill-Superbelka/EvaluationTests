//
//  AlbumCollectionView.swift
//  EvaluationTests
//
//  Created by Даниил  on 30.10.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

//class SearchBarView: UICollectionReusableView, UISearchBarDelegate{
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        print(text)
//    }
    
    
//}

class AlbumCollectionView: UICollectionViewController {

    @IBOutlet var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Запуск контроллера")
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
        
        return searchView
    }
}
