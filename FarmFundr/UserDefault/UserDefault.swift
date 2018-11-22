//
//  UserDefault.swift
//  FarmFundr
//
//  Created by Anupriya on 02/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
import Foundation
struct DefaultLeoUser {
    var id : Int?
    var email : String?
    var firstName : String?
    init(response: AnyObject) {
        if let body = response["payload"] as? [String: Any] {
            id = body["id"] as? Int
            email = body["email"] as? String
            firstName = body["firstName"] as? String
        }
    }
    init(id : Int ,email : String , firstName : String ) {
        self.id = id
        self.email = email
        self.firstName = firstName
    }
}
extension DefaultLeoUser {
    public func defaultLeoDictionary() -> [String: Any] {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.firstName, forKey: "firstName")
        let payload = NSMutableDictionary()
        payload.setValue(dictionary , forKey: "payload")
        return payload as! [String : Any]
    }
}
var defaultLeoDefaultUser: DefaultLeoUser? {
    get {
        if (UserDefaults.standard.object(forKey: "defaultLeoDefaultUser") != nil) {
            if let data = UserDefaults.standard.object(forKey: "defaultLeoDefaultUser") as? Data {
                let unarc = NSKeyedUnarchiver(forReadingWith: data)
                let rawValue = unarc.decodeObject(forKey: "root") as AnyObject
                return DefaultLeoUser(response: rawValue)
            } else {
                return nil
            }
        }
        return nil
    }
    set {
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: newValue?.defaultLeoDictionary() ?? ["":""])
        let ud = UserDefaults.standard
        ud.set( archiveData, forKey: "defaultLeoDefaultUser")
        ud.synchronize()
    }
}
