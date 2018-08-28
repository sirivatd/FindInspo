//
//  QuizViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 8/16/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit

var given_hashtags: [String] = ["Engagement", "WeddingBells", "WeddinfgPlanning", "WeddingPlanner", "WeddingDress", "weddingshower", "bachelorette", "wifetobe", "weddingphotography", "destinationwedding", "weddingbells", "weddingvenue", "manofmydreams", "womanofmydreams", "maidofhonor", "wedding", "luxurywedding", "luxuryhoneymoon", "dreamwedding", "wedding", "style", "bridetobe", "instawedding", "weddinggoals"]

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagLabel: UILabel!
    
    var count: Int = 0

    @IBAction func nextPressed() {
        self.count += 1
        if self.count >= 4 {
            self.count = 0

            self.dismiss(animated: true, completion: nil)

            self.presentDismiss()
        } else {
            let random_number = Int(arc4random_uniform(UInt32(given_hashtags.count - 1)))
            self.tagLabel.text = given_hashtags[random_number]
        }
    }
    
    func presentDismiss() {
        let alert = UIAlertController(title: "Quiz Done!", message: "Thank you for helping us curate your feed", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let random_number = Int(arc4random_uniform(UInt32(given_hashtags.count - 1)))
        let random_tag = given_hashtags[random_number]
        tagLabel.text = random_tag
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 40))
        title.textColor = UIColor.black
        title.text = "\(indexPath.row + 1)"
        title.textAlignment = .center
        cell.contentView.addSubview(title)
        
        return cell
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
