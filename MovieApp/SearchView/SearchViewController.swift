//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/2/22.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    
    @IBOutlet var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchtextField: UITextField!

    @IBAction func keyboardGo(_ sender: Any) {
        self.search()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        self.search()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchtextField.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.collectionViewLayout = createLayout()
    }
    
    func search() {
        viewModel.search(query: searchtextField.text ?? "", completion: { (succeeded: Bool, _: Error?) in
            if succeeded == true {
                self.searchCollectionView.reloadData()
            }
        })
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        self.search()
        return true
    }
}
