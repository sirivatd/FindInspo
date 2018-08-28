//
//  InputViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 7/29/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class InputViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var followers: UITextField!
    
    @IBOutlet weak var tags: UITextField!
    @IBOutlet weak var imageId: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var postCount: UITextField!
    
    @IBOutlet weak var linkUrl: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var followingCount: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        handle.delegate = self
        followers.delegate = self
        tags.delegate = self
        imageId.delegate = self
        category.delegate = self
        postCount.delegate = self
        linkUrl.delegate = self
        email.delegate = self
        followingCount.delegate = self

        ref = Database.database().reference()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func submitPressed() {
        
        
        let infoDict = ["name": name.text!, "handle": handle.text!, "followers": followers.text!, "tags": tags.text!, "imageId": imageId.text!, "category": category.text!, "postCount": postCount.text!, "linkUrl": linkUrl.text!, "email": email.text!, "followingCount": followingCount.text!]
        
        self.ref = Database.database().reference(withPath: "influencers")
        self.ref!.child("FindHealth").child(infoDict["handle"]!).setValue(infoDict)
        
        let alertControler = UIAlertController(title: "Influencer saved!", message: "Press okay to add more", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
            self.name.text = ""
            self.handle.text = ""
            self.followers.text = ""
            self.tags.text = ""
            self.imageId.text = ""
            self.category.text = ""
            self.postCount.text = ""
            self.linkUrl.text = ""
            self.email.text = ""
            self.followingCount.text = ""
        }
            
            alertControler.addAction(action1)
            
            self.present(alertControler, animated: true, completion: nil)
            
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

