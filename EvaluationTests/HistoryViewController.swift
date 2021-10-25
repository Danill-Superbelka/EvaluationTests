//
//  HistoryViewController.swift
//  EvaluationTests
//
//  Created by Даниил  on 24.10.2021.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet var historyTableView: UITableView!
    
    var history = [String]()
    
    let viewController = ViewController()
    
    var historyString: String = " "

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        history = UserDefaults.standard.array(forKey: "searchHistory") as? [String] ?? ["Записей нет"]
        historyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(history[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = "\(history[indexPath.row])"
        print("Нажата \(album)")
        Search.shared.search = album
        
//        let storyboard = UIStoryboard(name: "MainTabBarController", bundle: .main)
//        let tbc = storyboard.instantiateInitialViewController()
//        tbc?.modalPresentationStyle = .fullScreen
//        self.present(tbc!, animated: true, completion: nil)

        let tbc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        tbc.selectedIndex = 0
        tbc.modalPresentationStyle = .fullScreen
        self.present(tbc, animated: true, completion: nil)
    }
}