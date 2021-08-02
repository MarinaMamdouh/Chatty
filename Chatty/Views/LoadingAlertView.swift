//
//  LoadingAlertView.swift
//  Chatty
//
//  Created by Marina on 22/07/2021.
//

import UIKit

class LoadingAlertView: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nil
        self.message = "Please wait..."
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        self.view.addSubview(loadingIndicator)
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
