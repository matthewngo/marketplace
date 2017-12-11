//
//  ItemViewController.swift
//  Marketplace
//
//  Created by iGuest on 12/8/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ItemViewController: UIViewController {
    var itemDescription: NSDictionary = [:]
    var ref: DatabaseReference?
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var fullTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bestOfferLabel: UILabel!
    @IBOutlet weak var seller: UILabel!
    @IBOutlet weak var sellerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = itemDescription["imageURL"]  {
            downloadImage(url: url as! String) // compressing image, still need to fix
            //itemImg.clipsToBounds = true
            //itemImg.contentMode = .scaleAspectFill
        } else {
            itemImg.image = UIImage(named: "Camera")
        }
        let title = itemDescription["title"] as! String
        navTitle.title = title
        fullTitle.text = title
        price.text = "$\(itemDescription["price"] as! String)"
        let bestOffer = itemDescription["bestOffer"] as! Bool
        if !bestOffer {
            bestOfferLabel.isHidden = true
        } else {
            bestOfferLabel.isHidden = false
        }
        seller.text = itemDescription["email"] as! String
        sellerBtn.layer.cornerRadius = 7
        sellerBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 10, 6, 10) // top, left, bottom, right
    }
    
    public func downloadImage(url: String) {
        let imgUrl = URL(string: url)
        /*
        URLSession.shared.dataTask(with:imgUrl!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                self.itemImg.image = UIImage(data: data)
            } catch let error as NSError {
                print(error)
            }
        }).resume()*/
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: imgUrl!)
                DispatchQueue.global().sync {
                    self.itemImg.image = UIImage(data: data)
                }
            } catch  {
                // handle error
            }
        }
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
