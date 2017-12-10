//
//  ItemViewController.swift
//  Marketplace
//
//  Created by iGuest on 12/8/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    var itemDescription: NSDictionary = [:]
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var fullTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bestOfferLabel: UILabel!
    @IBOutlet weak var seller: UILabel!
    @IBOutlet weak var sellerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
