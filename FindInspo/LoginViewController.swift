//
//  LoginViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 7/29/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        signInRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signInRequest() {
        let url = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_IDS.AUTHURL, INSTAGRAM_IDS.CLIENTID, INSTAGRAM_IDS.REDIRECTURL, INSTAGRAM_IDS.SCOPE])
        let request = URLRequest.init(url: URL.init(string: url)!)
        webView.loadRequest(request)
    }
    
    func checkRequestForCallBackUrl(request: URLRequest) -> Bool {
        let URLString = (request.url?.absoluteString)! as String
        if URLString.hasPrefix(INSTAGRAM_IDS.REDIRECTURL) {
            let range: Range<String.Index> = URLString.range(of: "#access_token=")!
            getAccessToken(authToken: URLString.substring(from: range.upperBound))
            return false
        }
        
        return true
    }
    
    func getAccessToken(authToken: String) {
        self.navigationController?.popViewController(animated: true)
        let url = String(format: "https://api.instagram.com/v1/users/self/?access_token=%@", authToken)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                let strFullName = (json?.value(forKey: "data") as AnyObject).value(forKey: "full_name") as? String
                
                let alert = UIAlertController(title: "Full Name", message: strFullName, preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Ok action"), style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }.resume()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallBackUrl(request: request)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
