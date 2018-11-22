//
//  EventDetailsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 08/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStartNEndTime: UILabel!
    @IBOutlet weak var lblStartNEndDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var imgLand: UIImageView!
    
    //MARK:- Class Variable
    var eventId : Int?
    var apiEventDetailsIncomming : ApiGetEventListById?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if eventId != nil{
            postGetEventDetails(id: eventId!)
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Api GetEventDetail
    func postGetEventDetails(id : Int){
        let someRqst : [String : Any] = ["id" : id]
        HUD.show(.progress)
        WebServices.post(url: Api.getEventDetailByParticularId.url, jsonObject: someRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.apiEventDetailsIncomming = ApiGetEventListById(response: response as! NSDictionary)
                self.lblStartNEndDate.text = stringToDatestr(date: (self.apiEventDetailsIncomming?.eventDetail?.start_date!)!) + "-" + stringToDatestr(date: (self.apiEventDetailsIncomming?.eventDetail?.end_date!)!)
               self.lblStartNEndTime.text = stringToTimeStr(time:(self.apiEventDetailsIncomming?.eventDetail?.start_time!)!) + "-" + stringToTimeStr(time:(self.apiEventDetailsIncomming?.eventDetail?.end_time!)!)
           //     self.imgLand.load(url: URL(string: (self.apiEventDetailsIncomming?.eventDetail?.image!)!)!)
                self.txtViewDescription.text = self.apiEventDetailsIncomming?.eventDetail?.description?.htmlToString
                self.lblName.text = self.apiEventDetailsIncomming?.eventDetail?.name
               self.lblLocation.text = self.apiEventDetailsIncomming?.eventDetail?.location
                print("RESPONSE===", self.apiEventDetailsIncomming)
                self.imgLand.load(url: (self.apiEventDetailsIncomming?.eventDetail?.imgUrl)!)
            }
        }) { (error, _) in
            HUD.hide()
            self.view.makeToast(error.localizedDescription)
        }
    }
    
    @IBAction func actionOpenSideMenu(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
    
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
