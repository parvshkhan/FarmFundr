//
//  ApiGetContentsByParticularIdIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 22/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetContentsByParticularIdIncomming{
    var contentDetails : ContentsDetail?
    struct ContentsDetail {
        var page : Page?
        var headings : [Heading] = []
        struct Page {
            public var id : Int?
            public var title : String?
            public var description : String?
            public var image : String?
            var imgUrl : URL{
                if image != nil{
                    return URL(string: image!)!
                }
                return URL(string: "http://192.168.0.40/Agricultural_project/public/PageImage/1539584191knowledge_img1.png")!
            }
            
            init(dictionary : NSDictionary) {
                id = dictionary["id"] as? Int
                title = dictionary["title"] as? String
                description = dictionary["description"] as? String
                image = dictionary["image"] as? String
            }
        }
        struct Heading {
            public var id : Int?
            public var page_id : Int?
            public var title : String?
            var contents : [Content] = []
            struct Content {
                public var id : Int?
                public var page_headings_id : Int?
                public var question : String?
                public var answer : String?
                init(dictionary : NSDictionary) {
                    id = dictionary["id"] as? Int
                    page_headings_id = dictionary["page_headings_id"] as? Int
                    question = dictionary["question"] as? String
                    answer = dictionary["answer"] as? String
                }
            }
            init(headingResponse : AnyObject) {
                id = headingResponse["id"] as? Int
                page_id = headingResponse["page_id"] as? Int
                title = headingResponse["title"] as? String
                if let someContent = headingResponse["content"] as? [Any]{
                    for content in someContent{
                        let tempContent = Content(dictionary: content as! NSDictionary)
                        contents.append(tempContent)
                    }
                }
            }
        }
        init(contentsDictionary : AnyObject) {
            if let somePage = contentsDictionary["page"] as? NSDictionary{
                page = Page(dictionary: somePage)
            }
            if let someHeading = contentsDictionary["heading"] as? [Any]{
                for heading in someHeading{
                    let tempHeading = Heading(headingResponse: heading as AnyObject)
                    headings.append(tempHeading)
                }
            }
        }
        
    }
    init(response : NSDictionary) {
        if let someResponse = response["payLoad"] as? NSDictionary{
            contentDetails = ContentsDetail(contentsDictionary: someResponse)
        }
    }
}
