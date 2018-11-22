//
//  FirstSplashViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 05/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class FirstSplashViewController: UIViewController {

    @IBOutlet weak var lbltitle : UILabel!
    @IBOutlet weak var lblString : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbltitle.text = "find the best place you \n want by your location or \n or negihborhood "
        
        // find the best place you want by your location or negihborhood
//       postApi()
//        post1()
        // Do any additional setup after loading the view.
    }
    
    func post1(){
        let someRqst = ["userid" : "30d0d793-7732-4cee-a412-d2168f105dce"]
        let url = URL(string: "http://192.168.0.61/InfluencerAPI/CampaignList")!
        WebServices.post(url: url, jsonObject: someRqst, completionHandler: { (response, _) in
            print("Alamofire Response===",response)
        }) { (_, error) in
            print("ERROR")
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func postApi(){
        let url = URL(string: "http://192.168.0.61/InfluencerAPI/CampaignList")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // "userid": "30d0d793-7732-4cee-a412-d2168f105dce"
        let postString = "userid=30d0d793-7732-4cee-a412-d2168f105dce"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: [])) {
                print("userObject==", userObject)
                // you've got the jsonObject
            }else{
                print("error=\(error?.localizedDescription)")
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data!, encoding: .utf8)
            
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
}
