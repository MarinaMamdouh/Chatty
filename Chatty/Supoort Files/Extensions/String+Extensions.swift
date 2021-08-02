//
//  String+Extensions.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
extension String{
    
    // return a string after trimming the extra whitespaces from the end of the current string
    func trimmingWhiteSpaces()->String{
        let trimmed = self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        return trimmed
    }
    
}
