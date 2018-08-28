//
//  FindViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 8/16/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit
import Alamofire
import SSSpinnerButton

class FindViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var loader: SSSpinnerButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var timer = Timer()

    var titleName: String?
    var category: [String]?
    
    @IBAction func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func panCard(_ sender: UIPanGestureRecognizer) {
        let imageView = sender.view!
        let point = sender.translation(in: view)
        imageView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let xFromCenter = imageView.center.x - view.center.x
        let scale = min(100/abs(xFromCenter), 1)
        let divisor = (view.frame.width / 2) / 0.61
        imageView.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if sender.state == UIGestureRecognizerState.ended {
            if imageView.center.x < 75 {
                // Move off to the left
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x: imageView.center.x - 200, y: imageView.center.y + 50)
                    imageView.alpha = 0
                    print("THIS IS WHY@!!!!!!!!")
                    print("Disliked card!")
                    //self.reloadMatch()
                    self.loader.isHidden = false
                    self.loader.startAnimate(spinnerType: SpinnerType.ballRotateChase, spinnercolor: UIColor.white, complete: nil)
                    self.reloadMatch()
                    self.scheduledTimerWithTimeInterval()
                })
                return
            }
            else if imageView.center.x > (view.frame.width - 75) {
                // Move off to the right side
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x:imageView.center.x + 200, y: imageView.center.y + 50)
                    imageView.alpha = 0
                    print("THIS IS WHY!!!!!!!!!")
                    self.loader.isHidden = false
                    self.loader.startAnimate(spinnerType: SpinnerType.ballRotateChase, spinnercolor: UIColor.white, complete: nil)
                    self.reloadMatch()
                    self.scheduledTimerWithTimeInterval()
                    print("Liked card!")
                })
                return
            }
            else {
                self.resetView(sender: sender)
            }
        }
    }
    
    func reloadMatch() {
        let randomNumber = Int(arc4random_uniform(UInt32(self.category!.count - 1)))
        self.scrapeTags(instagram_tag: category![randomNumber])
        imageView.center = self.view.center
        imageView.alpha = 0
        imageView.transform = CGAffineTransform.identity
        
    }
    
    @objc func reloadImage() {
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView.center = self.view.center
            self.imageView.alpha = 1
            self.imageView.transform = CGAffineTransform.identity
        })
    }
    
    func resetView(sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.view!.center = self.view.center
            sender.view!.alpha = 1
            sender.view!.transform = CGAffineTransform.identity
        })
    }
    
    func scrapeTags(instagram_tag: String) {
        Alamofire.request("http://www.instagram.com/explore/tags/\(instagram_tag)/?__a=1").responseJSON { response in
            print("\(response.result.isSuccess)")
            
            guard let json = response.result.value as? [String: Any] else {
                print("Error converting to json")
                return
            }
            
            self.extractData(json: json)
        }
    }
    
    func extractData(json: [String: Any]) {
        let graphql = json["graphql"] as? [String: Any]
        let hashtag = graphql!["hashtag"] as! [String: Any]
        let edge_hashtag = hashtag["edge_hashtag_to_top_posts"] as! [String: Any]
        let edges = edge_hashtag["edges"] as! [[String: Any]]
        
        let random_number = Int(arc4random_uniform(UInt32(edges.count-1)))
        let currentEdge = edges[random_number]
        let node = currentEdge["node"] as! [String: Any]
        
        let edge_media = node["edge_media_to_caption"] as! [String: Any]
        let edge = edge_media["edges"] as! [[String: Any]]
        let node_edge = edge[0]
        let targetNode = node_edge["node"] as! [String: Any]
        
        print(targetNode["text"])
        print(node["display_url"])
        
        self.renderImage(givenView: self.imageView, imageString: node["display_url"] as! String)
        self.imageView.layer.shadowColor = UIColor.black.cgColor
        self.imageView.layer.shadowOpacity = 1
        self.imageView.layer.shadowOffset = CGSize.zero
        self.imageView.layer.shadowRadius = 10
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.clear.cgColor
        
        self.imageView.layer.cornerRadius = 5
        self.captionText.text = targetNode["text"] as! String
        
    }
    
    func renderImage(givenView: UIImageView, imageString: String) {
        let session = URLSession(configuration: .default)
        let imageURL = URL(string: imageString)
        givenView.load(url: imageURL!)
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(FindViewController.panCard))
        givenView.isUserInteractionEnabled = true
        
        givenView.addGestureRecognizer(panRecognizer)
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.reloadImage), userInfo: nil, repeats: false)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleName!
        self.loader.isHidden = true
        let randomNumber = Int(arc4random_uniform(UInt32(self.category!.count - 1)))
        self.scrapeTags(instagram_tag: category![randomNumber])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
