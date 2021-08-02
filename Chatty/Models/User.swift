//
//  User.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation

class User :Codable{
    var id:String
    var userName:String
    var email:String
    var phone:Int
    var imageURL:String?
    //var contacts:[Contact] = [Contact]()
    
    
    init(name:String, email e:String, phone p:Int) {
        id = UUID().uuidString
        userName = name
        phone = p
        email = e
    }
    init(id i:String , email e:String ) {
        id = i
        email = e
        userName = ""
        phone = 0
    }
}
