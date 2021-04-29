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
        
        // Logout firebase
        if (LoginWith.Firebase ==  Configure.LOGGED_IN_WITH){
            do {
                try Auth.auth().signOut()
                UIApplication.shared.windows.first?.rootViewController = LoginViewController()
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                Configure.LOGGED_IN_WITH = LoginWith.None
            }
            catch{ return }
        }
        
        // Logout facebook
        if( Configure.LOGGED_IN_WITH == .Facebook ){
            let fbButton = FBLoginButton()
            fbButton.center = view.center
            view.addSubview(fbButton)
            debugPrint("==> Facebook logout")
//            UIApplication.shared.windows.first?.rootViewController = LoginViewController()
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
            Configure.LOGGED_IN_WITH = LoginWith.None
            return;
        }
        
        // logout google
        if (Configure.LOGGED_IN_WITH == .Google){
            GIDSignIn.sharedInstance()?.signOut()
            UIApplication.shared.windows.first?.rootViewController = LoginViewController()
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            Configure.LOGGED_IN_WITH = LoginWith.None
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check user loggin with firebase
        if let user = Auth.auth().currentUser {
            label.text = user.email!
            return
        }
        
        // check user loggin with facebook
        if let _  = AccessToken.current?.tokenString {
            label.text = AccessToken.current?.tokenString
            let fbButton = FBLoginButton()
            fbButton.center = view.center
            fbButton.delegate = self
            view.addSubview(fbButton)
            
            return
        }
        
        if let _ = GIDSignIn.sharedInstance()?.currentUser {
            label.text = GIDSignIn.sharedInstance()?.currentUser.profile.email!
            return
        }
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
