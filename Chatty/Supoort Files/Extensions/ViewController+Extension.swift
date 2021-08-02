//
//  ViewController+Extension.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(with errorMessage:ErrorMessages){
        let alert =  UIAlertController(title: K.ERROR_KEYWORD, message: errorMessage.rawValue, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: K.ALERT_DURATION, target: self, selector: #selector(hideAlert), userInfo: [K.ALERT_KEY: alert], repeats: false)
    }
    
    @objc private func hideAlert(timer:Timer){
        let info = timer.userInfo as! [String:UIAlertController]
        let alert =  info[K.ALERT_KEY]
        alert?.dismiss(animated: true, completion: nil)
    }
    
    func start(loadingView:UIAlertController){
        loadingView.title = nil
        loadingView.message = "Please wait..."
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        loadingView.view.addSubview(loadingIndicator)
        present(loadingView, animated: true, completion: nil)
    }
    
    func stop(loadingView:UIAlertController){
        loadingView.dismiss(animated: false, completion: nil)
    }
}
