//
//  LandingViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 8/16/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit
import InstagramLogin
import Alamofire

class LandingViewController: UIViewController {

    var instagramLogin: InstagramLoginViewController!
    
    // 1. Set your client info from Instagram's developer portal (https://www.instagram.com/developer/clients/manage)
    let clientId = "efd39a1591da4fc284e0964cf6944855"
    let redirectUri = "https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=token"
    
    @IBAction func loginPressed() {
        self.loginWithInstagram()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loginWithInstagram() {
        
        // 2. Initialize your 'InstagramLoginViewController' and set your 'ViewController' to delegate it
        instagramLogin = InstagramLoginViewController(clientId: clientId, redirectUri: redirectUri)
        instagramLogin.delegate = self
        
        // 3. Customize it
        instagramLogin.scopes = [.basic, .publicContent] // [.basic] by default; [.all] to set all permissions
        instagramLogin.title = "Instagram" // If you don't specify it, the website title will be showed
        instagramLogin.progressViewTintColor = .blue // #E1306C by default
        
        // If you want a .stop (or other) UIBarButtonItem on the left of the view controller
        instagramLogin.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissLoginViewController))
        
        // You could also add a refresh UIBarButtonItem on the right
        instagramLogin.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
        
        // 4. Present it inside a UINavigationController (for example)
        present(UINavigationController(rootViewController: instagramLogin), animated: true)
    }
    
    @objc func dismissLoginViewController() {
        instagramLogin.dismiss(animated: true)
    }
    
    @objc func refreshPage() {
        instagramLogin.reloadPage()
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

extension LandingViewController: InstagramLoginViewControllerDelegate {
    
    func instagramLoginDidFinish(accessToken: String?, error: InstagramError?) {
        
        // And don't forget to dismiss the 'InstagramLoginViewController'
        instagramLogin.dismiss(animated: true)
       
            
            self.extractData()
        }
    
    
    func extractData() {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "scrape") as! ScrapeExampleViewController
        self.present(vc, animated: true, completion: nil)
    }
}
