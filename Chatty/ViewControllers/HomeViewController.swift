//
//  ViewController.swift
//  Chatty
//
//  Created by Marina on 20/07/2021.
//

import UIKit
import CLTypingLabel

class HomeViewController: UIViewController {
    @IBOutlet weak var chattyLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chattyLabel.text = K.APP_NAME
    }


}

