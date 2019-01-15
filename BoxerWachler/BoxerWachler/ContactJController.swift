//
//  ContactJController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 2/18/17.
//  Copyright © 2017 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class ContactJController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    var fname : String!
    var lname : String!
    var referral : String!
    var email : String!
    var addr1 : String!
    var addr2 : String!
    var phone : String!
    var comment : String!
    var requiredfieldname : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.delegate = self
        WebView.scrollView.bounces = false
        // check for internet availability
        Reachability.isInternetUp()
        
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoMenu))
        
        let rightLoadBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(self.reloadMethod))
        //self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem,rightAddBarButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem,rightLoadBarButtonItem], animated: true)
        //self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem], animated: true)
        //
        let localfilePath = Bundle.main.url(forResource: "contactform", withExtension: "html");
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
    func reloadMethod() {
        self.WebView.reload()
    }
    func gotoMenu() {
        //self.performSegue(withIdentifier: "mainmenu", sender: nil)
      
      fname = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('fname').value")
      if fname.isEmpty { requiredfieldname = "First Name is required!"; displayrequiredfield(); return }
      lname = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('lname').value")
      if lname.isEmpty { requiredfieldname = "Last Name is required!"; displayrequiredfield(); return }
      referral = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('referral').value")
      if referral.isEmpty { requiredfieldname = "Referral Source is required!"; displayrequiredfield(); return }
      email = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('email').value")
      if email.isEmpty { requiredfieldname = "Email address is required!"; displayrequiredfield(); return }
      addr1 = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('addr1').value")
      addr2 = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('addr2').value")
      phone = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('phone').value")
      comment = WebView.stringByEvaluatingJavaScript(from: "document.getElementById('comment').value")
      NSLog("the result is \(fname)")
      sendEmail()
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
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let fileUrl:String = (request.url?.lastPathComponent)!
        
        if navigationType == UIWebViewNavigationType.linkClicked {
            NSLog("clicked on=\(fileUrl)")
            if fileUrl == "contactform" {
                NSLog("send form")
                gotoMenu()
                return false
            }
        
        }
        if navigationType == UIWebViewNavigationType.linkClicked {
            NSLog("clicked on=\(fileUrl)")
            if fileUrl == "mapturn" {
                NSLog("perform seque")
                self.performSegue(withIdentifier: "mapturn", sender: nil)
                return false
            }
        }
        return true
    }
    func sendEmail() {
        // check if a valid email
        func isValidEmail(_ testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let range = testStr.range(of: emailRegEx, options:.regularExpression)
            let result = range != nil ? true : false
            return result
        }
        if (isValidEmail(email))
        {
            
        } else
        {
            let myMessage2 = "Please enter a valid Email"
            
            let myAlert = UIAlertController(title: myMessage2, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        // new 02/17/17
        var request = URLRequest(url: URL(string: "http://www.websoftmagic.com/boxer/mailboxer.php")!)
        request.httpMethod = "POST"
        //let postString = "email=tho@cox.net&message=Tom"
        //let myEmail = email.text!
        //let myFname = fname.text!
        NSLog("email=\(email!) and fname=\(fname!)")
        
        let postString = "fname=\(fname!)&lname=\(lname!)&email=\(email!)&referral=\(referral!)&addr1=\(addr1!)&addr2=\(addr2!)&phone=\(phone!)&comment=\(comment!)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        /*
         let request = NSMutableURLRequest(url: URL(string:
         "http://www.websoftmagic.com/boxer/mailboxer.php")!)
         request.httpMethod = "POST"
         let myEmail = eMail.text!
         let myMessage = textBody.text!
         NSLog("email=\(myEmail) and message=\(myMessage)")
         
         let postString = "email=\(myEmail)&message=\(myMessage)"
         request.httpBody = postString.data(using: String.Encoding.utf8)
         */
        /*
         let task = URLSession.shared.dataTask(with: request, completionHandler: { data,
         response, error in
         guard error == nil && data != nil else {
         // check for fundamental networking error
         print("error=\(error)")
         return
         }
         
         if let httpStatus = response as? HTTPURLResponse ,
         httpStatus.statusCode != 200 {           // check for http errors
         print("statusCode should be 200, but is \(httpStatus.statusCode)")
         print("response = \(response)")
         }
         
         let responseString = NSString(data: data!, encoding: String.Encoding.utf8)
         print("responseString = \(responseString)")
         // display thank you alert
         
         })
         
         task.resume()
         */
        let myMessage2 = "Message Sent\nThank You"
        
        let myAlert = UIAlertController(title: myMessage2, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(myAlert, animated: true, completion: nil)
        //
        /*
         // send via apple mail
         let mailComposeViewController = configuredMailComposeViewController()
         if MFMailComposeViewController.canSendMail() {
         self.presentViewController(mailComposeViewController, animated: true, completion: nil)
         } else {
         self.showSendMailErrorAlert()
         }
         */
        
    }
    
    func displayrequiredfield()  {
        let myAlert = UIAlertController(title: requiredfieldname, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(myAlert, animated: true, completion: nil)
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
