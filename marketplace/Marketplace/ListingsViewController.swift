//
//  ListingsViewController.swift
//  Marketplace
//
//  Created by Matthew Ngo on 12/3/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//
import Firebase
import UIKit

class ListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var ref: DatabaseReference?
    var itemCount: Int = 0
    var items: [String:Any]?
    var descriptions: [String:Any]?
    var selectedItem: NSDictionary = [:]
    var categories = ["Books", "Clothing", "Furniture", "Technology", "Tickets", "Other"]
    var s1: UISwitch = UISwitch()
    var s2: UISwitch = UISwitch()
    var s3: UISwitch = UISwitch()
    var s4: UISwitch = UISwitch()
    var s5: UISwitch = UISwitch()
    var s0: UISwitch = UISwitch()
    
    var switches: [UISwitch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switches = [s0, s1, s2, s3, s4, s5]
        ref = Database.database().reference()
        ref?.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return } // not necessary
            
            //print(snapshot)
            
            if let userName = snapshot.value as? [String:Any] {
                self.items = userName["items"] as? [String: Any]
                //print(self.items!.count)
                if(self.items == nil) {
                    self.itemCount = 0
                } else {
                    self.itemCount = self.items!.count
                    for key in self.items!.keys {
                        self.descriptions = self.items![key] as? [String:Any]
                    }
                }
            }
            
            // can also use
            // snapshot.childSnapshotForPath("full_name").value as! String
        })
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2 = UITableView()
        print(tableView2)
        //tableView2.delegate = self
        //tableView2.dataSource = self
        // Do any additional setup after loading the view.
    }

    // Workaround for ViewDidLoad after TableView
    override func viewDidAppear(_ animated: Bool) {
        tableView1.reloadData()
        //tableView2.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView2 {
            return categories.count
        } else {
            return itemCount
        }
    }
    
    @IBAction func unwindToListings(segue:UIStoryboardSegue) {
        NSLog("Listings")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView2 {
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            cell.textLabel!.text = categories[indexPath.row]
            cell.accessoryView = switches[indexPath.row]
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            var iter = items!.keys.makeIterator()
            var next:String = ""
            for _ in 0 ... indexPath.row {
                next = iter.next()!
            }
            descriptions = items![next] as? [String:Any]
        //print(descriptions!["title"]! as? String)
            cell.textLabel!.text = descriptions!["title"]! as? String
            let details: String = (descriptions!["price"]! as? String)!
            cell.detailTextLabel?.text = "$\(details)"
        //cell.imageView?.image = image[indexPath.row]
            return cell
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItem(path:Int) -> NSDictionary {
        var count = 0
        var dictionary: NSDictionary = [:]
        for (key, info) in self.items! {
            if (count == path) {
                return info as! NSDictionary
            } else {
                count = count + 1
            }
        }
        return [:]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PopoverSegue") {
            //print(table)
            let popover = segue.destination
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.popoverPresentationController?.delegate = self
            
        }
        if (segue.identifier == "itemView") {
            let controller = segue.destination as! ItemViewController
            let currentPath = self.tableView1.indexPathForSelectedRow!
            print("selected index: \(currentPath[1])")
           // self.items!.forEach { print($1) }
            selectedItem = getItem(path:currentPath[1])
            print(selectedItem)
            controller.itemDescription = selectedItem
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "itemView", sender:self)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
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
