//
//  UIView+Extension.swift
//  Chatty
//
//  Created by Marina on 23/07/2021.
//

import UIKit

extension UIView{
    func makeItCircle(){
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds =  true
    }
}
