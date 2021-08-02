//
//  Message.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
struct Message {
    let messageText:String
    let sender:User
    let date:Date
    let status:Status
}

enum Status {
    case notSent
    case sent
    case deliverd
    case seen
}
