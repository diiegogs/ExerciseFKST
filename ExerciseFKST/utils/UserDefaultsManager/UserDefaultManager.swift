//
//  UserDefaultManager.swift
//  ExerciseFKST
//
//  Created by Juan Diego Garcia Serrano on 23/09/25.
//

import Foundation

class UserDefaultManager {
    static let shared: UserDefaultManager = UserDefaultManager()
    
    private init() {()}
    
    func saveObject<T>(withKey: String, value: T) ->  Void where T: Encodable {
        do {
            let enconder: JSONEncoder = JSONEncoder()
            let data = try enconder.encode(value)
            UserDefaults.standard.set(data, forKey: withKey)
        } catch let error {
            print("error saving object: \(error.localizedDescription)")
        }
    }
    
    func loadObject<T>(withKey: String, type: T.Type) -> T? where T: Decodable {
        guard let data: Data = UserDefaults.standard.data(forKey: withKey) else {
            return nil
        }
        do {
            let decoder: JSONDecoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error {
            print("error loading object: \(error.localizedDescription)")
            return nil
        }
    }
}
