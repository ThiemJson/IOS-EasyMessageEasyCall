//
//  Configure.swift
//  EasyMessageEasyCall
//
//  Created by Teneocto on 29/04/2021.
//

import Foundation

class Configure {
    public static var GOOGLE_CLIENT_ID = "819912330349-5252kchit6s333fovo25vlf9rkj2s9hj.apps.googleusercontent.com"
    public static var GOOGLE_REVERSED_CLIENT_ID = "com.googleusercontent.apps.819912330349-5252kchit6s333fovo25vlf9rkj2s9hj"
    public static var LOGGED_IN_WITH : LoginWith = .None
}

enum LoginWith {
    case None
    case Facebook
    case Google
    case Firebase
}
