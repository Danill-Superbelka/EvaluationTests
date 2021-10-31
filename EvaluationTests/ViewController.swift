//
//  ViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 30.10.2021.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        

        let albumView = storyboard.instantiateViewController(withIdentifier: "Album") as! AlbumCollectionView
        let historyView = storyboard.instantiateViewController(withIdentifier: "History") as! HistoryTableView
        let album = storyboard.instantiateViewController(withIdentifier: "AlbumView") as! AlbumViewController

        
        viewControllers = [album, historyView]
        
    }
    


}
