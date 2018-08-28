//
//  ExploreViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 7/29/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit
import WebKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    

    var categoryImages: [String] = ["category1", "category2", "category3", "category4"]
    var categories: [String] = ["Beauty","Style","Culture","Health","Wedding","Family"]

    var category: [String]?
    

    @IBAction func buttonAPressed() {
        self.category = ["Engagement", "WeddingBells", "WeddinfgPlanning", "WeddingPlanner", "WeddingDress", "weddingshower", "bachelorette", "wifetobe", "weddingphotography", "destinationwedding", "weddingbells", "weddingvenue", "manofmydreams", "womanofmydreams", "maidofhonor", "wedding", "luxurywedding", "luxuryhoneymoon", "dreamwedding", "wedding", "style", "bridetobe", "instawedding", "weddinggoals"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonBPressed() {
        self.category = ["health","fit","workout","gains"]
        self.performSegue(withIdentifier: "toFind", sender: nil)

    }
    
    @IBAction func buttonCPressed() {
        self.category = ["culture", "cultured", "travel", "adventure", "paradise", "soul"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonDPressed() {
        self.category = ["beauty", "makeup", "tryon", "cute", "beautiful", "wcw"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonEPressed() {
        self.category = ["style","class","fashion","designer","clothes"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonFPressed() {
        self.category = ["family","familytrips","familymovies","parents"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewMethods
    

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFind" {
            let viewController: FindViewController = segue.destination as! FindViewController
            viewController.category = self.category!
        }
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
