//
//  ApiGetAllBlogList.swift
//  FarmFundr
//
//  Created by Anupriya on 05/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetAllBlogListIncomming {
    var blogDetails : [BlogDetail] = []
    struct BlogDetail {
        public var id : Int?
        public var post_by : String?
        public var title : String?
        public var description : String?
        public var created_at : String?
        public var image : String?
        var imageUrl : URL{
                return URL(string: image!.trimmingCharacters(in: .whitespaces)) ??  URL(string: "http://192.168.0.40/Agricultural_project/public/BlogImage/1538205902buy_organic_pears.jpg")!
     
        }
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            post_by = dictionary["post_by"] as? String
            title = dictionary["title"] as? String
            description = dictionary["description"] as? String
            created_at = dictionary["created_at"] as? String
            image = dictionary["image"] as? String
        }
    }
    init(response : AnyObject) {
        if let object = response["payload"] as? [Any]{
            for objects in object{
                let tempObject = BlogDetail(dictionary: objects as! NSDictionary)
                blogDetails.append(tempObject)
            }
        }
    }
}
