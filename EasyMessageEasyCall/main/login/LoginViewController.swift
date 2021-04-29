//
//  LoginViewController.swift
//  EasyMessageEasyCall
//
//  Created by Thiem Jason on 4/28/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var loginFacebookViewButton: UIView!
    @IBOutlet weak var loginGoogleViewButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewInitial()
    }
    
    private func viewInitial(){
        // Config Facebook login Button
        let fbloginButton = FBLoginButton()
        fbloginButton.delegate  = self
        loginFacebookViewButton.layer.masksToBounds = true
        fbloginButton.frame = loginFacebookViewButton.bounds
        loginFacebookViewButton.addSubview(fbloginButton)
        
        // Config Google login Button
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let ggLoginButton = GIDSignInButton()
        ggLoginButton.frame = loginGoogleViewButton.bounds
        loginGoogleViewButton.addSubview(ggLoginButton)
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        // Todo
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // Todo
    }
    
    
}
