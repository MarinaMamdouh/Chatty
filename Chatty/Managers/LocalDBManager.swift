//
//  LocalDBManager.swift
//  Chatty
//
//  Created by Marina on 21/07/2021.
//

import Foundation
import CoreData

class LocalDBManager {
    static let reference = LocalDBManager()
    private let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("User.plist")
    
    open func get<T>(dataType: T.Type) throws -> T? where T : Decodable{
        if let data = try? Data(contentsOf: dataPath!){
            let decoder = PropertyListDecoder()
            return try decoder.decode(dataType, from: data)
            
        }
        return nil
    }
    
    func save<Value>(data:Value) where Value : Encodable{
        let encoder = PropertyListEncoder()
        do{
            let dataType = try encoder.encode(data)
            try dataType.write(to: dataPath!)
        }catch{
            print("Error in writing the data to local database \(error)")
        }
    }
    
}
