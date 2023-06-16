//
//  LoginViewContoller.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/24/22.
//

import Foundation
import UIKit

class LoginViewContoller: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBAction func login(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        userNameTextField.text = "popaleksandar"
        passwordTextField.text = "coa123Car"
        viewModel.login(username: userNameTextField.text ?? "", password: passwordTextField.text ?? "",
                        completion: { (succeeded: Bool, problem: Error?) in
                            if succeeded == true {
                                self.viewModel.getSession(completion: { (succeeded: Bool, _: Error?) in
                                    if succeeded == true {
                                        self.viewModel.getUser()
                                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabbar") as UIViewController
                                        self.view.window?.rootViewController = vc
                                    } else {
                                        self.createAlert(alertTitle: "Alert", alertMessage: "Wrong Username/Password", actionTitle: "Try Again")
                                    }
                                })

                            } else {
                                button?.isEnabled = true
                                if let loginError = problem {
                                    self.createAlert(alertTitle: "Error", alertMessage: loginError.localizedDescription, actionTitle: "Ok")

                                } else {
                                    self.createAlert(alertTitle: "Alert", alertMessage: "Wrong Username/Password", actionTitle: "Try Again")
                                }
                            }
                        })
    }

    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y = view.frame.origin.y - keyboardSize.height
            } else {
                return
            }
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func createAlert(alertTitle: String, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
