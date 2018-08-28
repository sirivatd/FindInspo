//
//  CategoryViewController.swift
//  FindInspo
//
//  Created by Don Sirivat on 7/29/18.
//  Copyright © 2018 Don Sirivat. All rights reserved.
//

import UIKit

var currentUrl: String = ""

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var category: String?
    var categoryImages: [String] = ["beautyimage","styleimage","cultureimage","healthimage"]
    var beautyLinks: [String] = ["https://www.instagram.com/thecheekybeen/","https://www.instagram.com/gracevanderwaal/","https://www.instagram.com/majamalnar/","https://www.instagram.com/miamiamine/"]
    var styleLinks: [String] = ["https://www.instagram.com/davidkomalondon/","https://www.instagram.com/emvonhofsten/","https://www.instagram.com/misshayleypaige/","https://www.instagram.com/cmcoving/"]
    var cultureLinks: [String] = ["https://www.instagram.com/mrdoodle/","https://www.instagram.com/_jujujust_/","https://www.instagram.com/chemagdrl/","https://www.instagram.com/amirfarzad88/"]
    var healthLinks: [String] = ["https://www.instagram.com/melisfit_/","https://www.instagram.com/nudedudefood/","https://www.instagram.com/theshineproject/","https://www.instagram.com/cupcakesandyoga/"]
    
    var chosenUrl: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var consoleView: UIView!
    
    
    
    @IBAction func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        consoleView.frame.origin.y += 1000
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
            self.consoleView.frame.origin.y -= 1000
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "Find" + self.category!
        self.backgroundImage.image = UIImage(named: self.category!.lowercased() + "image")
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Collectionview Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfluencerCollectionViewCell
        cell.influencerImage.layer.cornerRadius = 8.0
        cell.influencerImage.clipsToBounds = true
        cell.influencerImage.image = UIImage(named: self.category!.lowercased() + "\(indexPath.row)")!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(self.category == "Health") {
            currentUrl = healthLinks[indexPath.row]
        } else if(self.category == "Style") {
            currentUrl = styleLinks[indexPath.row]
        } else if(self.category == "Beauty") {
            currentUrl = beautyLinks[indexPath.row]
        } else {
            currentUrl = cultureLinks[indexPath.row]
        }
        self.performSegue(withIdentifier: "toInternet", sender: nil)
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
