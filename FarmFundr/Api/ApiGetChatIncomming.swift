//
//  ApiGetChatIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 30/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
import UIKit
struct ApiGetChatsWithUserIncomming {
    struct ChatsWithUserItem {
        
        var id: Int?
        var adminId: Int?
        var userId: Int?
        var message: String?
        var role: String?
        var createdAt: String?
        var updatedAt: String?
        
        init(dictionary: NSDictionary)  // initialisation of dictionary
        {
          //  id = dictionary["id"] as? Int
            adminId = dictionary["adminId"] as? Int
            userId = dictionary["user_id"] as? Int
            message = dictionary["message"] as? String
            role = dictionary["role"] as? String
            createdAt = dictionary["created_at"] as? String
           // updatedAt = dictionary["updated_at"] as? String
        }
    }
    
    var chatsWithUserItems: [ChatsWithUserItem] = []
    init(response: AnyObject)
    {
        
        if let categoryList = response ["payload"] as? [Any] // PAYLOAD data
        {
            
            for object in categoryList
            {
                
                let someList = ChatsWithUserItem(dictionary: (object as? NSDictionary)!)
                chatsWithUserItems.append(someList)
                
                print("🦖🦖🦖galleryItems🦖🦖🦖",chatsWithUserItems)
                print("🚠🚠🚠someList🚠🚠🚠",someList)
            }
        }
    }
}
