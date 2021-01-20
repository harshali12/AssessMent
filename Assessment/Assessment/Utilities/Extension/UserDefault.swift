//
//  UserDefault.swift
//  Assessment
//
//  Created by APPLE on 19/01/21.
//

import Foundation

enum HNUserDefaultKey: String {
    case feedData = "feedData"
  
}

extension UserDefaults {
    func getSavedModelFromUserDefaults<T:Decodable>(type: T.Type , key: HNUserDefaultKey) -> T? {
        if let data = object(forKey: key.rawValue) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    
    func setModelInUserDefaults<T:Encodable>(value: T?, key: HNUserDefaultKey) {
        if let data = try? JSONEncoder().encode(value) {
            set(data, forKey: key.rawValue)
        }
    }
    
    static func deleteValueFromUserDefaults(key: HNUserDefaultKey) {
        UserDefaults.standard.set(nil, forKey: key.rawValue)
    }
    
    static func saveValueInUserDefault(value : Any , key: HNUserDefaultKey){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getValueFromUserDefault(key: HNUserDefaultKey) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
}
