//
//  EditViewController.swift
//  Marketplace
//
//  Created by iGuest on 12/4/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var about: UITextField!
    
    
    
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
