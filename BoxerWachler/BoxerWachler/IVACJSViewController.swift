//
//  IVACJSViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 6/9/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit
import WebKit

class IVACJSViewController: UIViewController, WKNavigationDelegate {
    
    var theWebView: WKWebView?
    
    @IBOutlet var containerView : UIView?
    @IBAction func displayButton(_ sender: UIButton) {
        theWebView!.evaluateJavaScript("generateDocument(1);") { (result, error) in
            if error != nil {
                print(result)
            }
        }
    //webView.evaluateJavaScript("document.generateDocument(1);", completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "ivac", ofType: "html" )
        let url = URL(fileURLWithPath:path!)
        let request = URLRequest(url:url)
        let theConfiguration = WKWebViewConfiguration()
        
        
        theWebView = WKWebView(frame:self.containerView!.frame, configuration: theConfiguration)
        
        
        
        theWebView!.loadHTMLString(path!, baseURL: nil)
        
        theWebView!.load(request)
        
        self.containerView!.addSubview(theWebView!)
        
        
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
