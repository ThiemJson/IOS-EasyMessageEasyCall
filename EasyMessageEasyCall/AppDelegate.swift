//
//  AppDelegate.swift
//  EasyMessageEasyCall
//
//  Created by Thiem Jason on 4/28/21.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            return
          }
        
        debugPrint("====> LOGGED IN WITH GOOGLE <====")
        debugPrint(user.userID!);
        debugPrint(user.authentication.idToken!);
        debugPrint(user.profile.name!);
        debugPrint(user.profile.givenName!);
        debugPrint(user.profile.familyName!);
        debugPrint(user.profile.email!);
        debugPrint("====> --------------------- <====")
          
        UIApplication.shared.windows.first?.rootViewController = HomeViewController()
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        Configure.LOGGED_IN_WITH = LoginWith.Google
    }
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool { ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions );
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = Configure.GOOGLE_CLIENT_ID
        GIDSignIn.sharedInstance().delegate = self
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }
    
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool { ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        return GIDSignIn.sharedInstance().handle(url)
    }

    // MARK: UISceneSession Lifecycle
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

