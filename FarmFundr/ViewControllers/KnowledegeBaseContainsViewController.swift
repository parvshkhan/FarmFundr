//
//  KnowledegeBaseContainsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 16/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class KnowledegeBaseContainsViewController: UIViewController {
    //MARK:- Outlets
     @IBOutlet weak var webView : UIWebView!
    //MARK:- Class Variables
    var pageURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestObj = URLRequest(url: pageURL!)
        webView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }

    @IBAction func actionBackBtn(_ sender : UIButton){
       self.navigationController?.popViewController(animated: true)
        
    }

}
