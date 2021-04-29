//
//  LoginFirebaseViewController.swift
//  EasyMessageEasyCall
//
//  Created by Teneocto on 29/04/2021.
//

import UIKit
import Combine
import Firebase

class LoginFirebaseViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    @IBAction func login(_ sender: Any) {
        viewModel.loginFirebaseEvent.send(FirebaseUser(id: "", email: email.text!, password: pass.text!))
    }
    
    @IBAction func forgot(_ sender: Any) {
        navigationController?.present(FirebaseSignUpViewController(), animated: true, completion: nil)
    }
    public var viewModel : LoginFirebaseViewModel!
    public var cancelable = Set<AnyCancellable>();
    
    deinit {
        cancelable.forEach{ $0.cancel() }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show navigation
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.title = "LOG IN"
        
        viewModel = LoginFirebaseViewModel()
        viewModel.loginFirebaseState.sink { completion in
            debugPrint(completion)
        } receiveValue: { status in
            switch status {
            case .loading:
                break
            case .login:
                let user = Auth.auth().currentUser
                let alert = UIAlertController(title: "Firebase Login Message", message: "Log in Successfuly. Hi \(String(describing: user?.email)) ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                    UIApplication.shared.windows.first?.rootViewController = HomeViewController()
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    Configure.LOGGED_IN_WITH = LoginWith.Firebase
                }))
                self.present(alert, animated: true, completion: nil)
                break
            case .logout:
                let alert = UIAlertController(title: "Firebase Login Message", message: "Logout Successfuly", preferredStyle:  .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
                break
            case .failure:
                let alert = UIAlertController(title: "Firebase Login Message", message: "Login Fail. Please check your account or internet connection", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            }
        }.store(in: &cancelable)
        
    }
}
