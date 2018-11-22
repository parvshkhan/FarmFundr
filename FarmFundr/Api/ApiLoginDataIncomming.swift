//
//  ApiLoginDataIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 29/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//
/*{
    isError = 0;
    isSuccess = 1;
    message = "Thanks for login with Farm Partner";
    payLoad =     {
        email = "anu08@gmail.com";
        "first_name" = Anu;
        id = 9;
        "last_name" = "<null>";
        mobile = 0;
    };
} */
import Foundation
struct ApiLoginDataIncomming {
    var userLogin : LoginDetails?
    struct LoginDetails {
        var email : String?
        var firstName : String?
        var id : Int?
        init(dictionary : NSDictionary) {
            email = dictionary["email"] as? String
            firstName = dictionary["first_name"] as? String
            id = dictionary["id"] as? Int
        }
    }
    init(response : [String : Any]) {
        if let someResponse = response["payLoad"] as? [String : Any]{
            userLogin = LoginDetails(dictionary: someResponse as NSDictionary)
        }
    }
}
