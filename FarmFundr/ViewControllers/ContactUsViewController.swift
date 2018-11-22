//
//  ContactUsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 30/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblChat : UITableView!
     @IBOutlet weak var txtMsg : UITextField!
    // Mark Variables
    var apiChatDataIncomming : ApiGetChatsWithUserIncomming?

    override func viewDidLoad() {
        super.viewDidLoad()
        postGetChat()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - post Api Integeration
    @IBAction func actionSendMsgBtn(_ sender : UIButton){
        if txtMsg.text == ""{
            self.view.makeToast("Please Enter Your Message!")
            return
        }else{
            postChat(id : (defaultLeoDefaultUser?.id!)! , message : txtMsg.text!)
           txtMsg.text = ""
        }
    }
    
    //MARK:- Action openMenu
    
    @IBAction func actionOpenSideMenu(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    @IBAction func actionShowInformation(_ sender : UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InFormationViewController") as! InFormationViewController
   vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
      self.present(vc, animated: true, completion: nil)
    }
    
    
    
    // MARK: - PostChat Api Integeration
    func postChat(id : Int , message : String){
        let chatRqst : [String : Any] = ["id" :id,"message":message]
      //  HUD.show(.progress)
        WebServices.post(url: Api.postChat.url , jsonObject: chatRqst, completionHandler: { (response, _ ) in
           // HUD.hide()
            if isApiSussess(response: response){
                self.postGetChat()
            }
        }) { (error, _ ) in
            print("Error")
        }
    }
    
    // MARK: - GetChat Api Integeration
    func postGetChat(){
        let chatRqst : [String : Any] = ["id":(defaultLeoDefaultUser?.id!)!]
      //  HUD.show(.progress)
        WebServices.post(url: Api.getChat.url, jsonObject: chatRqst, completionHandler: { (response, _) in
        //    HUD.hide()
            self.apiChatDataIncomming = ApiGetChatsWithUserIncomming(response: response)
            DispatchQueue.main.async {
                self.tblChat.reloadData()
            }
        }) { (error, _) in
           print("Error")
        }
    }
}

extension ContactUsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiChatDataIncomming?.chatsWithUserItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let someChat = apiChatDataIncomming?.chatsWithUserItems[indexPath.row]
        if someChat?.role == "customer"{
         let  cell1 = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell") as! UserChatTableViewCell
           cell1.lblUserMsg.text = someChat?.message
            return cell1
        }else{
            let  cell2 = tableView.dequeueReusableCell(withIdentifier: "AdminChatTableViewCell") as! AdminChatTableViewCell
            cell2.lblAdminMsg.text = someChat?.message
            return cell2
        }
    }
    
}

class UserChatTableViewCell : UITableViewCell{
    @IBOutlet weak var lblUserMsg : UILabel!
    
}

class AdminChatTableViewCell : UITableViewCell{
    @IBOutlet weak var lblAdminMsg : UILabel!
    
}
