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
    
    var count: Int = 1
    var timer = Timer()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var featuredImg: UIImageView!
    
    @IBAction func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    

    var categoryImages: [String] = ["category1", "category2", "category3", "category4"]
    var categories: [String] = ["Beauty","Style","Culture","Health","Wedding","Family"]

    var category: [String]?
    var titleName: String?
    

    @IBAction func buttonAPressed() {
        self.category = ["Engagement", "WeddingBells", "WeddinfgPlanning", "WeddingPlanner", "WeddingDress", "weddingshower", "bachelorette", "wifetobe", "weddingphotography", "destinationwedding", "weddingbells", "weddingvenue", "manofmydreams", "womanofmydreams", "maidofhonor", "wedding", "luxurywedding", "luxuryhoneymoon", "dreamwedding", "wedding", "style", "bridetobe", "instawedding", "weddinggoals"]
        self.titleName = "FindWedding"
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonBPressed() {
        self.category = ["health","fit","workout","gains","fitness","fitnessmodel","fitfam","lovelife","fitchick","workoutfit","fitspo","girlswholift","fitmama","abs","fitnessmotivation","1upnutrition","healthy","fitsporation","fitjourney","crushfit","workout","run","active","igfitness","girlswholift","healthyrecipes","healthyish","healthylifestyle","healthyfood","healthylife"]
        self.titleName = "FindFit"
        self.performSegue(withIdentifier: "toFind", sender: nil)

    }
    
    @IBAction func buttonCPressed() {
        self.titleName = "FindCulture"
        self.category = ["culture", "cultured", "travel", "adventure", "paradise", "soul","travelholic","travelblogger","travelguide","travelling","travelers","travel_greece","travels","travelbag","travelbook","travelingram","travelgram","travelbug","traveldiary","travelandlife","traveladdict", "cultureclash","cultureclub","culturel","culturetrip", "cultureday"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonDPressed() {
        self.titleName = "FindBeauty"
        self.category = ["beauty", "makeup", "tryon", "cute", "beautiful", "wcw", "beautyful", "beautyblender","beautycare","beautycounter","beautygirl","beautybox","beautysecret","beautytime","skincare","skincareroutine","makeuptutorial","makeupparty","makeupwedding","makeuponpoint","chanel"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonEPressed() {
        self.titleName = "FindStyle"
        self.category = ["style","class","fashion","designer","clothes", "balibodyresults","pfoto","aw2018","miami","instawatch","ootn","wiw","outfit","clothes","accessories","fashionable","fashionaddict", "jewelry","instastyle","hairstyle","look","lookbook","outfitoftheday","shoes","streetwear","styleblogger","stylish","trend","trendy","wiwt","whatiwore"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @IBAction func buttonFPressed() {
        self.titleName = "FindFamily"
        self.category = ["family","familytrips","familymovies","parents","instalove","instafamily","instahome","instahouse","instalife","home","familytime","familyday","familyfun","brothers","sisters","sis","familyfirst", "dad","mom"]
        self.performSegue(withIdentifier: "toFind", sender: nil)
    }
    
    @objc func updateImage() {
        UIView.transition(with: self.featuredImg,
                          duration:2,
                          options: .transitionCrossDissolve,
                          animations: { self.featuredImg.image = UIImage(named: "explore\(self.count%8)") },
                          completion: nil)
        self.count += 1
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scheduledTimerWithTimeInterval()

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
            viewController.titleName = self.titleName!
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
