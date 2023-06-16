//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/3/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var name: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var id: UILabel!

    let viewModel = ProfileViewModel()

    
    @IBAction func logout(_ sender: Any) {
        self.viewModel.logout()
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewContoller") as UIViewController
        self.view.window?.rootViewController = vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUser(completion: { (succeeded: Bool, _: Error?) in
            if succeeded == true {
                self.setupUI()
            }
        })
    }

    func setupUI() {
        name.text = viewModel.dataSource?.name
        username.text = viewModel.dataSource?.username
        id.text = "\(String(describing: viewModel.dataSource?.id ?? 0))"
    }
}
