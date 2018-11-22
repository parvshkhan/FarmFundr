//
//  PageControlVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 13/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

/*import UIKit

class PageControlVC: UIViewController,UIScrollViewDelegate,TAPageControlDelegate
{
@IBOutlet weak var scrollView: UIScrollView!
    
   var index = 0
   var timer = Timer()
    
    var customPageControl2 = UIPageControl()
    
    var imageData = NSArray()
    var labelData = NSArray()
    var labelData2 = NSArray()
    var buttonData = NSArray()
    var labelData3 = NSArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.imageData = ["first", "second","third"]
        self.labelData = ["Discover Place Near You","Search For Place Easily","Ready To Invest In This Place"]
        self.labelData2 = ["Find the best place you want by your location or neighborhood","Find the best place you want by your location or neighborhood","Find the best place you want by your location or neighborhood"]
        
       self.buttonData = ["Get Started","Get Started","Get Started"]
       self.labelData3 = ["Next","Next","Get Started"]
        
        for i in 0..<self.imageData.count
        {
            print(i)
            let xPos =  self.view.frame.size.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x:xPos, y: 0, width: self.view.frame.width, height: self.scrollView.frame.size.height))
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: self.imageData[i] as! String)
            self.scrollView.addSubview(imageView)
        }

        for k in 0..<self.labelData.count
        {
            print(k)
            let xPos =  self.view.frame.size.width * CGFloat(k)
          let labels = UILabel(frame: CGRect(x:xPos+20, y:self.view.frame.height/2, width: self.view.frame.width/2, height: 150))
            labels.numberOfLines = 0
            labels.lineBreakMode = .byWordWrapping
            labels.textColor = UIColor.white
            labels.text = self.labelData[k] as? String
            labels.font = UIFont.boldSystemFont(ofSize: 35.0)
            
            self.scrollView.addSubview(labels)
        }
        
        for j in 0..<self.labelData2.count
        {
            let xPos =  self.view.frame.size.width * CGFloat(j)
            let labelss = UILabel(frame: CGRect(x:xPos+20, y:self.view.frame.height/2+135, width: self.view.frame.width/2, height: 100))
            labelss.numberOfLines = 0
            labelss.lineBreakMode = .byWordWrapping
            labelss.textColor = UIColor.white
            labelss.text = self.labelData2[j] as? String
            labelss.font = labelss.font.withSize(17)
            self.scrollView.addSubview(labelss)
        }
       
        for b in 0..<self.buttonData.count
        {
            let button = UIButton(frame: CGRect(x:self.view.frame.width-100, y:self.view.frame.height-100, width:100, height:50))
            //button.setTitle("GET STARTED", for:.normal)
            button.setTitle(self.buttonData[b] as? String, for:.normal)
            button.setTitleColor(UIColor(displayP3Red:56.0/255.0, green:146.0/255.0, blue:93.0/255.0, alpha:1.0), for:.normal)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = button.frame.size.height/2
            button.layer.masksToBounds = true

            button.addTarget(self, action:#selector(move2Login), for:.touchUpInside)

            self.scrollView.addSubview(button)
    }
      self.scrollView.delegate = self
        index=0
        //self.scrollView.frame.origin.y+self.scrollView.frame.size.height
        self.customPageControl2 = TAPageControl(frame: CGRect(x: 20, y:self.scrollView.frame.size.height-50, width: self.scrollView.frame.size.width/4, height: 40))
        self.customPageControl2.delegate = self
        self.customPageControl2.numberOfPages =  self.imageData.count
        self.customPageControl2.dotSize = CGSize(width: 20, height: 20)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(self.imageData.count), height: self.scrollView.frame.size.height)
        self.view.addSubview(self.customPageControl2)
 }
    
   @objc func move2Login()
   {
       let vc = storyboard?.instantiateViewController(withIdentifier:"SignInVC") as! SignInVC
       self.navigationController?.pushViewController(vc, animated:true)
   }
    
 override func viewDidAppear(_ animated: Bool)
    {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runImages), userInfo:nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool)
    {
        timer.invalidate()
    }
    
    @objc func runImages()
    {
        self.customPageControl2.currentPage = index
        if index == self.imageData.count - 1
        {
            index=0
        }else{
            index = index + 1
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        self.customPageControl2.currentPage = Int(pageIndex)
        index = Int(pageIndex)
    }
   
}
*/
