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

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var id: String = ""
    var itemDescription: NSDictionary = [:]
    var ref: DatabaseReference?
    var sections = ["Condition", "Description", "Category"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var fullTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bestOfferLabel: UILabel!
    @IBOutlet weak var seller: UILabel!
    @IBOutlet weak var sellerBtn: UIButton!
    
    override func viewDidLoad() {
        print(id)
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if itemDescription["imageURL"] as! String != ""  {
            let url = itemDescription["imageURL"]
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
        /*
         URLSession.shared.dataTask(with:imgUrl!, completionHandler: {(data, response, error) in
         guard let data = data, error == nil else { return }
         do {
         self.itemImg.image = UIImage(data: data)
         } catch let error as NSError {
         print(error)
         }
         }).resume()*/
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = itemDescription["condition"] as! String
            if itemDescription["conditionComment"] as! String != ""  {
                cell?.detailTextLabel?.text = "Comment: \(itemDescription["conditionComment"] as! String)"
            }
        } else if indexPath.section == 1 {
            cell?.textLabel?.text = itemDescription["description"] as! String
        } else {
            cell?.textLabel?.text = itemDescription["category"] as! String
        }
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int) -> String? {
        return sections[section]
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
