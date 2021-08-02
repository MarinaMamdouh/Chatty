//
//  NetworkManager.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
import UIKit
import Firebase
class NetworkManager {
    static let reference = NetworkManager()
    // instance of firebase auth
    let firebaseAuthenticator  =  Auth.auth()
    // instance of firebase db
    let firebaseDatabase = Firestore.firestore()
    // instasnce of firebase storage
    var firebaseStorage:StorageReference {
        get{
            let storgae = Storage.storage()
            return storgae.reference(forURL: K.Network.FIREBASE_STORAGE_URL)
        }
    }
    
    
    func upload(image:UIImage, withName name:String, completion:@escaping (_ url:String?,_ error:Error?)->()){
        // Create a reference to the file you want to upload
        let imageChild = firebaseStorage.child(K.Network.PROFILE_IMAGES_DB_CHILD_NAME).child(name)
        guard let imageData = image.jpegData(compressionQuality: 0.4) else{
            // error
            completion(nil,JpegErrorData())
            return
        }
        let metaData =  StorageMetadata()
        metaData.contentType = "image/jpeg"
        // Upload the file to the path "images/rivers.jpg"
        _ = imageChild.putData(imageData, metadata: metaData, completion:{ (metadata, error) in
            if error != nil {
                // Uh-oh, an error occurred!
                completion(nil,error)
                return
            }
            // You can also access to download URL after upload.
            imageChild.downloadURL { (url, error) in
                if error != nil{
                    completion(nil,error)
                    return
                }
                completion(url?.absoluteString, nil)
            }
        })
    }
    
    func updateDB(collection:String , documentName:String , info:[String:Any] ,completion:@escaping (_ error:Error?)->()){
        
        firebaseDatabase.collection(collection).document(documentName).setData(info, merge: true, completion: { error in
            if error != nil {
                completion(error)
                return
            }
            completion(nil)
        })
    }
    
    func getDataFromDB(collection:String , documentName:String , completion:@escaping (_ data:[String:Any]?, _ error:Error?)->()){
        let docRef = firebaseDatabase.collection(collection).document(documentName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(){
                    completion(data,nil)
                }else{
                    completion([:],nil)
                }
            } else {
                completion(nil ,error)
            }
        }
    }
    
    
    
    
}
