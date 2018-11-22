//
//  DemoViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController,URLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate {
    
    var urlLink: URL!
    var defaultSession: URLSession!
    var downloadTask: URLSessionDownloadTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        defaultSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self as! URLSessionDelegate, delegateQueue: OperationQueue.main)
        // Do any additional setup after loading the view.
    }
    
    func startDownloading () {
    let url = URL(string: "http://smartit.ventures/farm/Agricultural_project/public/Docx/1.615372361271E+15LoremIpsum.docx")!
        let url1 = URL(string: "http://smartit.ventures/farm/Agricultural_project/public/Docx/1.6153661489697E+15Farm_Fields_&_Equipment_(6997664574).jpg")!
        downloadTask = defaultSession.downloadTask(with: url)
        downloadTask.resume()
    }


    

    @IBAction func actionDwnld(_ sender : UIButton){
    //http://smartit.ventures/farm/Agricultural_project/public/Docx/1.6153660698561E+15Book1.xlsx%22
//        let url = URL(string: "http://smartit.ventures/farm/Agricultural_project/public/Docx/1.6153660698561E+15Book1.xlsx%22")!
        
        startDownloading()
        
    }
    
    func showFileWithPath(path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self as! UIDocumentInteractionControllerDelegate
            viewer.presentPreview(animated: true)
        }
        
    }
    
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print(downloadTask)
        print("File download succesfully")
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/file.doc"))
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            showFileWithPath(path: destinationURLForFile.path)
            print(destinationURLForFile.path)
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                showFileWithPath(path: destinationURLForFile.path)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
 
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      //  Progress.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        downloadTask = nil
     //   progress.setProgress(0.0, animated: true)
        if (error != nil) {
            print("didCompleteWithError \(error?.localizedDescription ?? "no value")")
        }
        else {
            print("The task finished successfully")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {
        return self
    }
    
    
    
}

