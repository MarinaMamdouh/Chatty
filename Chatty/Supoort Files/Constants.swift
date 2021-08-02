//
//  Constants.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
struct K {
    static let ERROR_KEYWORD = "ERROR"
    static let ALERT_KEY  = "alert"
    static let ALERT_DURATION = 3.0
    static let APP_NAME = "Chatty"
    
    struct Segues {
        static let REGISTER_TO_CONTACTS = "RegisterToContacts"
        static let SIGNIN_TO_CONTACTS = "SignInToContacts"
    }
    
    struct Network {
        static let FIREBASE_STORAGE_URL = "gs://chatty-b1762.appspot.com"
        static let USERS_DB_COLLECTION_NAME = "Users"
        static let PROFILE_IMAGES_DB_CHILD_NAME = "ProfileImages"
        static let USER_NAME_FIELD = "name"
        static let IMAGE_URL_FIELD = "imageURL"
        static let PHONE_FIELD = "phone"
    }
}
