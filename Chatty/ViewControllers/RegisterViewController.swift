//
//  RegisterViewController.swift
//  Chatty
//
//  Created by Marina on 20/07/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageBackgroundView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var RegisterButton: UIButton!
    
    // MARK: - Private Properties
    private var imagePicker = UIImagePickerController()
    private let loadingAlert = LoadingAlertView(title: nil, message: nil, preferredStyle: .alert)
    private var selectedImage:UIImage?
    
    // MARK: - VC LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // draw Circle Profile Picture
        imageBackgroundView.makeItCircle()
        profileImage.makeItCircle()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func cameraBtnClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        guard let userName = userNameTextField.text?.trimmingWhiteSpaces(),
              let userPhone = Int((phoneTextField.text?.trimmingWhiteSpaces())!),
              let userEmail = emailTextField.text?.trimmingWhiteSpaces(),
              let userPassword = passwordTextField.text else{
            showAlert(with: .someEmptyFields)
            return
        }
        
        let user = User(name: userName,email: userEmail, phone: userPhone)
        present(loadingAlert, animated: true, completion: nil)
        
        UserManager.reference.registerNew(user: user, with: userPassword, and: selectedImage) { sucess, error in
            // go the main thread to access UI compontents
            DispatchQueue.main.async {
                // task is finished so stop loading indicator
                self.loadingAlert.dismiss(animated: true, completion: nil)
                // check on sucess of the task
                if sucess {
                    // succeeded so go to Contacts VC
                    self.performSegue(withIdentifier: K.Segues.REGISTER_TO_CONTACTS, sender: nil)
                    return
                }
                // failed so show error Alert
                print(error!.localizedDescription)
                self.showAlert(with: .registerationFailed)
            }
            
        }
    }
    
    
}

// MARK: - UIImagePicker Delegate Methods

extension RegisterViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        profileImage.image = image
        selectedImage = image
        // draw Circle Profile Picture
        imageBackgroundView.makeItCircle()
        profileImage.makeItCircle()
    }
    
}
