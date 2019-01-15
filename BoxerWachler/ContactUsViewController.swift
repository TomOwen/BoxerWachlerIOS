//
//  ContactUsViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 4/25/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

    class ContactUsViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var eMail: UITextField!
    @IBOutlet weak var textBody: UITextView!
    @IBAction func CallBoxer(_ sender: UIButton) {
        NSLog("call now")
        if let url = URL(string: "tel://9494434040") {
            UIApplication.shared.openURL(url)
        }
    }

    @IBAction func sendEmail(_ sender: AnyObject) {
        // check if a valid email
        func isValidEmail(_ testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let range = testStr.range(of: emailRegEx, options:.regularExpression)
            let result = range != nil ? true : false
            return result
        }
        if (isValidEmail(eMail.text!))
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
        let myEmail = eMail.text!
        let myMessage = textBody.text!
        NSLog("email=\(myEmail) and message=\(myMessage)")
        
        let postString = "email=\(myEmail)&message=\(myMessage)"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // select text
        self.textBody.becomeFirstResponder()
        textBody.selectedTextRange = textBody.textRangeFromPosition(textBody.beginningOfDocument, toPosition: textBody.endOfDocument)
        */
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["tho@cox.net"])
        mailComposerVC.setSubject("Message to BoxerWachler Vision Institute")
        mailComposerVC.setMessageBody(self.textBody.text, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
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
