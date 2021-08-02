//
//  UserManager.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
import UIKit
import Firebase

class UserManager {
    
    // MARK: - Public Properties
    static let reference = UserManager()
    public var user:User? {
        if currentUser != nil{
            return currentUser
        }
        currentUser = getCurrentUserFromLocalDevice()
        return currentUser
    }
    
    // MARK: - Private Properties
    private var currentUser:User?
    private var currentUserImage:UIImage?
    private let userDBCollection = K.Network.USERS_DB_COLLECTION_NAME
    private let userNameKey = K.Network.USER_NAME_FIELD
    private let userPhoneKey = K.Network.PHONE_FIELD
    private let userImageUrlKey = K.Network.IMAGE_URL_FIELD
    
    // MARK: - Local Device Methods
    private func getCurrentUserFromLocalDevice() -> User?{
        do{
            let user = try LocalDBManager.reference.get(dataType: User.self)
            return user
        }
        catch{
            print(error)
            return nil
        }
    }
    
    private func saveCurrentUserToLocalDevice(){
        LocalDBManager.reference.save(data: currentUser)
    }
    
    // MARK: - Authentication Methods
    func registerNew(user:User, with password:String ,and profileImage:UIImage?, completion: @escaping (_ success: Bool , _ error:Error?) -> Void){
        // register the user to firebase
        currentUser = user
        currentUserImage = profileImage
        NetworkManager.reference.firebaseAuthenticator.createUser(withEmail: user.email, password: password) { data, error in
            if error != nil {
                self.currentUser = nil
                completion(false,error!)
                return
            }
            if let currentUser = data?.user{
                self.currentUser!.id = currentUser.uid
                // upload user photo if any
                if let image = self.currentUserImage{
                    NetworkManager.reference.upload(image:image, withName: currentUser.uid) { url, error in
                        if let safeUrl =  url {
                            self.currentUser?.imageURL = safeUrl
                            let photoInfo = [self.userImageUrlKey:safeUrl]
                            // complete user profile on cloud
                            self.completeUserProfile(info: photoInfo) { error in
                                // completed
                            }
                        }
                    }
                }
                // complete uploading user profile to the cloud
                let userInfo:[String:Any] = [self.userNameKey:self.currentUser!.userName ,
                                             self.userPhoneKey:self.currentUser!.phone]
                self.completeUserProfile(info: userInfo) { error in
                    if error != nil{
                        completion(false,error)
                        return
                    }
                    self.saveCurrentUserToLocalDevice()
                    completion(true,nil)
                    
                    
                }
                
            }
        }
    }
    
    
    
    func loginUser(with email:String,and password:String, completion:@escaping (_ success: Bool , _ error:Error?) -> Void) {
        // login with Email and password
        NetworkManager.reference.firebaseAuthenticator.signIn(withEmail: email, password: password) { data, error in
            // if they are not correct returns Error and User object is nil
            if let e = error{
                completion(false,e)
                return
            }
            // if they are correct then returns the User data annd error nil
            let email =  data?.user.email!
            let uid = data?.user.uid
            self.currentUser =  User(id: uid!, email: email!)
            // get the user Full Profile (phone , name , imageURL if exists)
            self.getUserProfile(uid: uid!) { error in
                guard let e = error else{
                    self.saveCurrentUserToLocalDevice()
                    completion(true, nil)
                    return
                }
                completion(false, e)
            }
            
        }
        
    }
    
    private func completeUserProfile(info:[String:Any] ,completion:@escaping (_ error:Error?)->()){
        NetworkManager.reference.updateDB(collection: userDBCollection, documentName: currentUser!.id, info: info) { error in
            if error != nil{
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    private func getUserProfile(uid:String,completion:@escaping (_ error:Error?)->()){
        NetworkManager.reference.getDataFromDB(collection: userDBCollection, documentName: uid) { info, error in
            // no profile is retrieved
            guard let userInfo = info else{
                completion(error)
                return
            }
            // mendatory fields ( name , phone)
            guard let userName = userInfo[self.userNameKey] , let phone = userInfo[self.userPhoneKey] else{
                completion(NoInfoPassed())
                return
            }
            // update currentuser object
            self.currentUser?.userName = userName as! String
            self.currentUser?.phone = phone as! Int
            // optional fields (ImageURL)
            if let imageURL = userInfo[self.userImageUrlKey]{
                self.currentUser?.imageURL = imageURL as? String
            }
            completion(nil)
        }
        
    }
    
    // MARK: - Contacts Methods
    func addContact(phone:Int, completion:(Contact, Error)){
        // add contact by phone number
        // if there is a user with this phone number
        // then Contact is returned and error is nil
        // if there is no contact with this phone
        // then error is returned and contact object is nill
    }
    
    func send(message:Message,to contact:Contact,completion:(Message, Error)->()){
        // send message to contact
    }
    
    func getConversation(of contact:Contact, completion:([Message], Error)) {
        // get all conversation between current user and contact
    }
}
