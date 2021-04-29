//
//  FirebaseSignUpViewController.swift
//  EasyMessageEasyCall
//
//  Created by Teneocto on 29/04/2021.
//

import UIKit
import Firebase

class FirebaseSignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: pass.text!) { authResult, error in
            if error != nil {
                debugPrint((error?.localizedDescription)!)
                let alert = UIAlertController(title: "Firebase SignUp Message", message: "SignUp Fail. Please check your account or internet connection", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return;
            }
            
            let alert = UIAlertController(title: "Firebase SignUp Message", message: "Sign Up successful", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [ weak self ] _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil);

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
