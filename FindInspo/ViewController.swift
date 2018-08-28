//
//  ViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 7/28/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var givenURL: String?
    
    @IBAction func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black

    }

    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: currentUrl)
        if let unwrappedURL = url {
            webView.load(URLRequest(url: url!))
            webView.allowsBackForwardNavigationGestures = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

