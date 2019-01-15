//
//  EyeExamViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 5/26/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class EyeExamViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.delegate = self
        WebView.scrollView.bounces = false
        //
        let localfilePath = Bundle.main.url(forResource: "eyeexam", withExtension: "html");
        let myRequest = URLRequest(url: localfilePath!);
        WebView.loadRequest(myRequest);
        //
        /*
         let url = NSURL (string: "http://www.drwilliamgroff.com");
         let myRequest = NSURLRequest(URL: url!);
         WebView.loadRequest(myRequest);
         */
        // Do any additional setup after loading the view.
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // if an ipad then use a different viewcontroller
        var sequeId: String = "colorvisiontest"
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            sequeId = "colorvisiontest2"
        }
        let fileUrl:String = (request.url?.lastPathComponent)!
        
        if navigationType == UIWebViewNavigationType.linkClicked {
            NSLog("clicked on=\(fileUrl)")
            if fileUrl == "colorvisiontest" {
                
                NSLog("perform seque")
                self.performSegue(withIdentifier: sequeId, sender: nil)
                return false
            }
            if fileUrl == "visionacuitytest" {
                NSLog("perform seque")
                self.performSegue(withIdentifier: "visionacuitytest", sender: nil)
                return false
            }
            if fileUrl == "begineyetest" {
                NSLog("perform seque")
                self.performSegue(withIdentifier: "begineyetest", sender: nil)
                return false
            }

            if fileUrl == "samplesnelling" {
                NSLog("perform seque")
                self.performSegue(withIdentifier: "samplesnelling", sender: nil)
                return false
            }
        }
        /*
         if navigationType == UIWebViewNavigationType.LinkClicked {
         if (request.URL!.host! == "example.com"){
         return true
         } else {
         UIApplication.sharedApplication().openURL(request.URL!)
         return false
         }
         }
         */
        return true
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.isHidden = false
        activity.startAnimating()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
        activity.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
