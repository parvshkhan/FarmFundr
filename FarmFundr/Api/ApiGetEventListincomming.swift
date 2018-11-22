//
//  ApiGetEventListincomming.swift
//  FarmFundr
//
//  Created by Anupriya on 06/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetEventListIncomming {
    var eventDetails : [EventDetail] = []
    struct EventDetail {
        public var id : Int?
        public var name : String?
        public var description : String?
        public var start_date : String?
        public var end_date : String?
        public var start_time : String?
        public var end_time : String?
        public var location : String?
        public var post_by : String?
        public var mobile : String?
        public var organizer : String?
        public var organizer_image : String?
        public var organizer_email : String?
        public var image : String?
        var imgUrl : URL{
                return URL(string: image!) ?? URL(string: "http://192.168.0.40/Agricultural_project/public/PropertyThumbnail/1538051576Agricultural-Land.jpg")!
        }
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            name = dictionary["name"] as? String
            description = dictionary["description"] as? String
            start_date = dictionary["start_date"] as? String
            end_date = dictionary["end_date"] as? String
            start_time = dictionary["start_time"] as? String
            end_time = dictionary["end_time"] as? String
            location = dictionary["location"] as? String
            post_by = dictionary["post_by"] as? String
            mobile = dictionary["mobile"] as? String
            organizer = dictionary["organizer"] as? String
            organizer_image = dictionary["organizer_image"] as? String
            organizer_email = dictionary["organizer_email"] as? String
            image = dictionary["image"] as? String
        }
    }
  
    init(response : AnyObject) {
        if let someEvents = response["payload"] as? [Any]{
            for events in someEvents{
                let tempEvents = EventDetail(dictionary: events as! NSDictionary)
                eventDetails.append(tempEvents)
            }
        }
    }
}
