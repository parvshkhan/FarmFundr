//
//  ApiGetBlogDetailsIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 05/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetBlogDetails {
    var blog : Blog?
    struct Blog {
        public var id : Int?
        public var post_by : Int?
        public var title : String?
        public var description : String?
        public var created_at : String?
        public var image : String?
        var imgUrl : URL{
            if image != nil{
                return URL(string: image!)!
            }
            return  URL(string: "http://192.168.0.40/Agricultural_project/public/PropertyThumbnail/1538051576Agricultural-Land.jpg")!
        }
        public var postBy : String?
        var comments : [Comment] = []
        struct Comment {
            public var id : Int?
            public var message : String?
            public var created_at : String?
            public var author : String?
            public var authorImg : String?
            init(dictionary : NSDictionary) {
                id = dictionary["id"] as? Int
                message = dictionary["message"] as? String
                created_at = dictionary["created_at"] as? String
                author = dictionary["author"] as? String
                authorImg = dictionary["authorImg"] as? String
            }
        }
        init(dictionary : AnyObject) {
            id = dictionary["id"] as? Int
            post_by = dictionary["post_by"] as? Int
            title = dictionary["title"] as? String
            description = dictionary["description"] as? String
            created_at = dictionary["created_at"] as? String
            image = dictionary["image"] as? String
            postBy = dictionary["postBy"] as? String
            if let someComment = dictionary["comment"] as? [Any]{
                for comment in someComment{
                    let tempComment = Comment(dictionary: comment as! NSDictionary)
                    comments.append(tempComment)
                }
            }
        }
    }
    init(response : NSDictionary) {
        if let blogResponse = response["payload"] as? NSDictionary{
            blog = Blog(dictionary: blogResponse)
        }
    }
}
