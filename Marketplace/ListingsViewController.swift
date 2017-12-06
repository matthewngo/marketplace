//
//  ListingsViewController.swift
//  Marketplace
//
//  Created by Matthew Ngo on 12/3/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//
import Firebase
import UIKit

class ListingsViewController: UIViewController,  UIPopoverPresentationControllerDelegate{

    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref?.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return } // not necessary
            
            //print(snapshot)
            
            if let userName = snapshot.value as? [String:Any] {
                print(userName)
            }
            
            // can also use
            // snapshot.childSnapshotForPath("full_name").value as! String
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PopoverSegue") {
            //print(table)
            let popover = segue.destination
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.popoverPresentationController?.delegate = self
        }
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
