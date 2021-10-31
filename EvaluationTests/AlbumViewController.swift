//
//  AlbumViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 31.10.2021.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
   
    private var albumModel: AlbumModel!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    let data = [1,2,3,4,5,6,7]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.keyboardDismissMode = .onDrag
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .red
        
        return cell
    }
}


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumName: UILabel!
    
//    func displayContent(title: String){
//        albumName.text = title
//    }
}
