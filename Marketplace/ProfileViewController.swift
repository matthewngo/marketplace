//
//  ProfileViewController.swift
//  Marketplace
//
//  Created by iGuest on 12/4/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    var aboutData = [String]()
    var database = [String:Any]()
    var ref:DatabaseReference?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var classYear: UILabel!
    @IBOutlet weak var about: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref?.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            if let currentData = snapshot.value as? [String:Any] {
                self.database = currentData
            }
            // Do any additional setup after loading the view.
        })
    }
    
    @IBAction func unwindToProfile(segue:UIStoryboardSegue) {
        
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

