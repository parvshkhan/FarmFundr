//
//  IntroductionViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 19/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
class IntroductionViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var tblContentList : UITableView!
    //MARK:- Class Variables
    var apiGetContentsById : ApiGetContentsByParticularIdIncomming?
    var pageId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        postGetContentsByParticularId(pageId : pageId!)
        // Do any additional setup after loading the view.
    }
    
    //
    
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- OpenSide Menu
    
    @IBAction func actionMenuBtn(_ sender : UIButton){
        toggleSideMenuView()
    }
    
    
    
    
    // MARK : GetContents Api Integeration
    
    func postGetContentsByParticularId(pageId : Int){
        let urlStr = URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getContentByParticularId")!
        let someRqst : [String : Any] = ["id" : pageId]
       // HUD.show(.progress)
        WebServices.post(url: urlStr, jsonObject: someRqst, completionHandler: { (response, _) in
           // HUD.hide()
            self.apiGetContentsById = ApiGetContentsByParticularIdIncomming(response: response as! NSDictionary)
            print("RESPONSE===", response)
            print("ResponseDictionary=======🍫🍫🍫🍫",self.apiGetContentsById)
            self.lblTitle.text = self.apiGetContentsById?.contentDetails?.page?.title
            DispatchQueue.main.async {
                self.tblContentList.reloadData()
            }
            
        }) { (error, _) in
            self.view.makeToast(error.localizedDescription)
        }
    }
}

//MARK:- TableViewDelegate And DataSources
extension IntroductionViewController : UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return apiGetContentsById?.contentDetails?.headings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.apiGetContentsById?.contentDetails?.headings[section].title as? String
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetContentsById?.contentDetails?.headings[section].contents.count ?? 0
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "introductionTableViewCell") as! introductionTableViewCell
        let some = apiGetContentsById?.contentDetails?.headings[indexPath.section].contents[indexPath.row]
        cell.lblques.text = some?.question
        cell.lblanswr.text = some?.answer?.htmlToString
        return cell
    }
  
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = AppColors.white.color
            headerView.textLabel?.font = UIFont(name: "BreeSerif-Regular", size: 20)!
            headerView.textLabel?.textAlignment = .center
            headerView.textLabel?.numberOfLines = 0
            headerView.textLabel?.lineBreakMode = .byWordWrapping
            headerView.textLabel?.textColor = AppColors.green.color
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    
}

class introductionTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var lblques : UILabel!
     @IBOutlet weak var lblanswr : UILabel!
    //MARK:- Class Variables
    var apiGetContents : ApiGetContentsByParticularIdIncomming?
    
    func configureContets(apiGetContents : ApiGetContentsByParticularIdIncomming)  {
        self.apiGetContents = apiGetContents
        
    }
    
    
}
