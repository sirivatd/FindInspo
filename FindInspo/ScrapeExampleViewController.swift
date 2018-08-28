//
//  ScrapeExampleViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 8/16/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import CTSlidingUpPanel

var given_influencers: [String] = ["taylorswift","kimkardashian","anwarhadid","warukatta","fridacashflow","hannahdonker","muscle.union","goddess_of_muscle","miamiamine","melisfit_"]

class ScrapeExampleViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var biographyTextView: UITextView!
    
    var currentHandle: String?
    
    @IBAction func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toInstagramPressed() {
        if let url = NSURL(string: "http://instagram.com/\(self.currentHandle!)") {
            UIApplication.shared.openURL(url as URL)
        }
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
                    self.reloadMatch()
                })
                return
            }
            else if imageView.center.x > (view.frame.width - 75) {
                // Move off to the right side
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x:imageView.center.x + 200, y: imageView.center.y + 50)
                    imageView.alpha = 0
                    print("THIS IS WHY!!!!!!!!!")
                    self.reloadMatch()
                    print("Liked card!")
                })
                return
        }
            else {
                self.resetView(sender: sender)
            }
        }
    }
    
    var bottomController: CTBottomSlideController?
    
    var currentImage: UIImage?
    
    func resetView(sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.view!.center = self.view.center
            sender.view!.alpha = 1
            sender.view!.transform = CGAffineTransform.identity
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView.frame = CGRect(x: self.imageView.frame.minX, y: self.imageView.frame.minY, width: self.imageView.frame.width, height: self.imageView.frame.height)
            self.imageView.layer.cornerRadius = self.imageView.frame.height/2
            self.imageView.alpha = 1.0
            
        })
    }
    
    func reloadMatch() {
        let randomNumber = Int(arc4random_uniform(UInt32(given_influencers.count - 1)))
        self.scrapeInstagram(instagram_handle: given_influencers[randomNumber])
        imageView.center = self.view.center
        imageView.alpha = 1
        imageView.transform = CGAffineTransform.identity
        
    }
    
    func scrapeInstagram(instagram_handle: String) -> Void {
        self.currentHandle = instagram_handle
        Alamofire.request("http://www.instagram.com/\(instagram_handle)/?__a=1").responseJSON { response in
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
        let user = graphql!["user"] as? [String: Any]
        let biographyText = user!["biography"] as! String
        let fullName = user!["full_name"] as! String
        
        let followed_by = user!["edge_followed_by"] as! [String: Any]
        let followers = followed_by["count"] as! Int
        
        let following_by = user!["edge_follow"] as! [String: Any]
        let following = following_by["count"] as! Int
        self.handleLabel.text = user!["username"] as! String

        let edge_owner = user!["edge_owner_to_timeline_media"] as! [String: Any]
        let postCount = edge_owner["count"] as! Int
        let edges = edge_owner["edges"] as! [[String: Any]]
        let node1 = edges[0] as! [String: Any]
        let node2 = edges[1] as! [String: Any]
        let node3 = edges[2] as! [String: Any]
        let node4 = edges[3] as! [String: Any]
        
        let to_media = node1["node"] as! [String: Any]
        let firstImage = to_media["display_url"] as! String
        
        let to_media1 = node2["node"] as! [String: Any]
        let secondImage = to_media1["display_url"] as! String
        
        let to_media2 = node3["node"] as! [String: Any]
        let thirdImage = to_media2["display_url"] as! String
        
        let to_media3 = node4["node"] as! [String: Any]
        let fourthImage = to_media3["display_url"] as! String
        
        self.renderImage(givenView: self.imageView, imageString: firstImage)
        self.renderImage(givenView: self.profileImageView, imageString: user!["profile_pic_url_hd"] as! String)
        self.renderImage(givenView: self.image1, imageString: secondImage)
        self.renderImage(givenView: self.image2, imageString: thirdImage)
        self.renderImage(givenView: self.image3, imageString: fourthImage)
        
        self.nameLabel.text = fullName
        self.followersLabel.text = "\(followers)"
        self.followingLabel.text = "\(following)"
        self.postsLabel.text = "\(postCount)"
        self.biographyTextView.text = biographyText
        
        print(biographyText)
        print(fullName)
        print(followers)
        print(following)

    }
    
    func renderImage(givenView: UIImageView, imageString: String) {
        print("Trying to render")
        let session = URLSession(configuration: .default)
        let imageURL = URL(string: imageString)
        givenView.load(url: imageURL!)
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(ScrapeExampleViewController.panCard))
        givenView.isUserInteractionEnabled = true
        
        givenView.addGestureRecognizer(panRecognizer)
//        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
//        let downloadPicTask = session.dataTask(with: imageURL!) { (data, response, error) in
//            // The download has finished.
//            if let e = error {
//                print("Error downloading picture: \(e)")
//            } else {
//                // No errors found.
//                // It would be weird if we didn't have a response, so check for that too.
//                if let res = response as? HTTPURLResponse {
//                    print("Downloaded picture with response code \(res.statusCode)")
//                    if let imageData = data {
//                        // Finally convert that Data into an image and do what you wish with it.
//                        let image = UIImage(data: imageData)
//                        self.currentImage = image!
//                        self.updateImage()
//
//                        // Do something with your image.
//                    } else {
//                        print("Couldn't get image: Image is nil")
//                    }
//                } else {
//                    print("Couldn't get response code for some reason")
//                }
//            }
//        }
//        downloadPicTask.resume()
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        bottomController = CTBottomSlideController(parent: view, bottomView: bottomView,
                                                   tabController: nil,
                                                   navController: nil, visibleHeight: 64)
        //0 is bottom and 1 is top. 0.5 would be center
        bottomController?.setAnchorPoint(anchor: 0.3)
        let randomNumber = Int(arc4random_uniform(UInt32(given_influencers.count - 1)))
        self.scrapeInstagram(instagram_handle: given_influencers[randomNumber])
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
