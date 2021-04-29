//
//  LoginFirebaseViewModel.swift
//  EasyMessageEasyCall
//
//  Created by Teneocto on 29/04/2021.
//

import Foundation
import Combine
import Firebase

enum FirebaseAuthStatus {
    case logout
    case login
    case loading
    case failure
}

class LoginFirebaseViewModel {
    public var loginFirebaseEvent = PassthroughSubject<FirebaseUser, Error>()
    public var loginFirebaseState = PassthroughSubject<FirebaseAuthStatus, Error>()
    private var authState : AuthStateDidChangeListenerHandle!
    private var cancelable = Set<AnyCancellable>()
    
    
    init() {
        authState = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if( user != nil ){
                debugPrint("====> LOGGED IN WITH FIREBASE <====")
                debugPrint(user?.uid as Any);
                debugPrint(user?.email as Any);
                debugPrint("====> --------------------- <====")
                return;
            }
        })
        
        loginFirebaseEvent
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: true)
            .sink { complete in
            debugPrint("loginFirebaseEvent complete")
        } receiveValue: { firebaseUser in
            self.signIn(firebaseUser: firebaseUser)
        }.store(in: &cancelable)
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(authState!)
        cancelable.forEach{ $0.cancel() }
    }
    
    private func signIn(firebaseUser: FirebaseUser) {
        Auth.auth().signIn(withEmail: firebaseUser.email, password: firebaseUser.password) { [ weak self ] (authResult, error) in
            if error != nil {
                self!.loginFirebaseState.send(FirebaseAuthStatus.failure)
                debugPrint((error?.localizedDescription)!)
                return;
            }
            
            self?.loginFirebaseState.send(FirebaseAuthStatus.login)
        }
    }
    // sig
}
