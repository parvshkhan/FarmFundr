//
//  EventsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 08/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblEventData : UITableView!
    //MARK:- Class Variables
    var apiGetEventListIncomming : ApiGetEventListIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblEventData.estimatedRowHeight = 220
        tblEventData.rowHeight = UITableViewAutomaticDimension
        tblEventData.delegate = self
         tblEventData.dataSource = self
        postGetEventList()
        // Do any additional setup after loading the view.
    }
    //MARK:- GetEventList ViewController
    func postGetEventList(){
        let someRqst = ["" : ""]
        HUD.show(.progress)
        WebServices.post(url: Api.getEventList.url, jsonObject: someRqst, completionHandler: { (response, _) in
            HUD.hide()
            self.view.makeToast(getMessage(response: response))
            if isApiSussess(response: response){
                self.apiGetEventListIncomming = ApiGetEventListIncomming(response: response)
                print("DATA===",self.apiGetEventListIncomming)
                DispatchQueue.main.async {
                    self.tblEventData.reloadData()
                }
            }
        }) { (error, _) in
             HUD.hide()
            self.view.makeToast(error.localizedDescription)
            print("ERROR===",error)
        }
    }
 
    @IBAction func actionOpenSideMenu(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        let initialViewControlleripad : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SideNavigationController") as! SideNavigationController
        //      self.view.window = self.view.bounds
        self.view.window?.rootViewController = initialViewControlleripad
        self.view.window?.makeKeyAndVisible()
        
    }
    
    
}

extension EventsViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetEventListIncomming?.eventDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let someEvent = apiGetEventListIncomming?.eventDetails[indexPath.row]
     let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier ) as! EventListTableViewCell
    cell.configure(eventDetail: someEvent!)
    cell.closurDidTapOnJoin = { event in
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
          vc.eventId = event.id
          self.navigationController?.pushViewController(vc, animated: true)
        }
    return cell
    }
    
}


//MARK:- TableViewCell Class
class EventListTableViewCell : UITableViewCell{
    //MARK:- Outlets
    @IBOutlet weak var imgLand: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStartNEndTime: UILabel!
    @IBOutlet weak var lblStartNEndDt: UILabel!
    
    //MARK:- Class Variables
    static let identifier = "EventListTableViewCell"
    var  eventDetail : ApiGetEventListIncomming.EventDetail?
    let dateFormatter = DateFormatter()
    var closurDidTapOnJoin : ((ApiGetEventListIncomming.EventDetail) -> Void)?
    //MARK:- Actions
    
    @IBAction func actionJoinBtn(_ sender: UIButton) {
        closurDidTapOnJoin?(eventDetail!)
    }
    
    /*let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
     let date = dateFormatter.date(from: strDate)*/
    
    //MARK:- Method to configure Data
    func configure(eventDetail :ApiGetEventListIncomming.EventDetail) {
        self.eventDetail = eventDetail
        lblName.text = eventDetail.name
        lblStartNEndDt.text = stringToDatestr(date: eventDetail.start_date!) + "-" + stringToDatestr(date: eventDetail.end_date!)
        lblStartNEndTime.text = stringToTimeStr(time:eventDetail.start_time!) + "-" + stringToTimeStr(time:eventDetail.end_time!)
       print(stringToTimeStr(time: eventDetail.start_time!))
       print(stringToDatestr(date: eventDetail.start_date!))
       imgLand.load(url:eventDetail.imgUrl )
        
    }
}



