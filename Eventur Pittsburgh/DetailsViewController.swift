//
//  DetailsViewController.swift
//  Eventur Pittsburgh
//
//  Created by Simiao on 4/20/16.
//  Copyright © 2016 Yu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIWebViewDelegate {
    
    
    
    // outlet - web view
    @IBOutlet var myWebView: UIWebView!
    
    // refresh button
    @IBAction func refreshButtonClicked(sender: UIBarButtonItem) {
        self.refreshWebView()
    }
    
    
    // link to browse (this value set by parent controller)
    var link: String?
    
    
    
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set webview delegate
        self.myWebView.delegate = self
        

        
        // load url in webview
        if let fetchURL = NSURL(string: self.link! ) {
            let urlRequest = NSURLRequest(URL: fetchURL)
            self.myWebView.loadRequest(urlRequest)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Webview delegate
    
    func webViewDidFinishLoad(webView: UIWebView) {
        

    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading url.")
    }
    
    
    
    
    // MARK: - Utility function
    
    // refresh webview
    func refreshWebView(){
        
        
        // reload webview
        self.myWebView.reload()
        
    }
    
    // show alert with ok button
    private func showAlertMessage(alertTitle alertTitle: String, alertMessage: String ) -> Void {
        
        // create alert controller
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert) as UIAlertController
        
        // create action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
            { (action: UIAlertAction) -> Void in
                // you can add code here if needed
        })
        
        // add ok action
        alertCtrl.addAction(okAction)
        
        // present alert
        self.presentViewController(alertCtrl, animated: true, completion: { (void) -> Void in
            // you can add code here if needed
        })
    }
    
    
}