//
//  ApiUserRegisterIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 29/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiUserSignUpInComming {
    var userData : UserDetails?
    struct UserDetails {
        var email : String?
        var firstName : String?
        // first_name
        var id : Int?
        var mabile : String?
        init(dictionary : NSDictionary) {
            email = dictionary["email"] as? String
            firstName = dictionary["first_name"] as? String
            id = dictionary["id"] as? Int
            mabile = dictionary["mobile"] as? String
        }
    }
    
    init(response : [String : Any]) {
        if let someData = response["payLoad"] as? [String : Any]{
            userData = UserDetails(dictionary: someData as NSDictionary)
        }
    }
}
