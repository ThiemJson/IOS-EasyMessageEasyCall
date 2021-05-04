//
//  HomeViewController.swift
//  EasyMessageEasyCall
//
//  Created by Teneocto on 29/04/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class HomeViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        // todo
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // todo
    }
    
    public var user: String = ""
    @IBOutlet weak var label : UILabel!
    
    @IBAction func firebaseLogout(_ sender: Any) {
        debugPrint("==> signout")
        do {
            try Auth.auth().signOut()
        }
        catch{ return }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check user loggin with firebase
        if let user = Auth.auth().currentUser?.uid {
            label.text = user
            return
        }
        
        // Do any additional setup after loading the view.
    }
}
