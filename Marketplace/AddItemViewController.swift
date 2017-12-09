//
//  AddItemViewController.swift
//  Marketplace
//
//  Created by Lauren Antilla on 12/1/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddItemViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var ref: DatabaseReference?
    var seller: String?
    var downloadURL: URL?
    
    @IBOutlet weak var booksCategory: UITableViewCell!
    @IBOutlet weak var clothingCategory: UITableViewCell!
    @IBOutlet weak var furnitureCategory: UITableViewCell!
    @IBOutlet weak var techCategory: UITableViewCell!
    @IBOutlet weak var ticketCategory: UITableViewCell!
    @IBOutlet weak var otherCategory: UITableViewCell!
    var categoryArray: [UITableViewCell] = []
 
    
    @IBOutlet weak var itemImage: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var bestOfferSwitch: UISwitch!
    @IBOutlet weak var descriptionField: UITextField!
    
    var itemCondition: String = "New"
    var itemCategory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksCategory.accessoryType = .none
        clothingCategory.accessoryType = .none
        furnitureCategory.accessoryType = .none
        techCategory.accessoryType = .none
        ticketCategory.accessoryType = .none
        otherCategory.accessoryType = .none
        categoryArray = [booksCategory, clothingCategory, furnitureCategory, techCategory, ticketCategory, otherCategory]
        
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        ref = Database.database().reference()
        let itemsRef = Database.database().reference(withPath: "items")
        let item = itemsRef.childByAutoId()
        var on = true
        if bestOfferSwitch.isOn {
            on = true
        } else {
            on = false
        }
        ref?.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            if let userName = snapshot.value as? [String:Any] {
                let user = userName["currentUser"] as? [String:Any]
                let currentUser = user!["email"] as! String
                item.child("email").setValue(currentUser)
            }
        })
        item.child("title").setValue(titleField.text)
        checkCondition()
        item.child("condition").setValue(itemCondition)
        item.child("conditionComment").setValue(commentField.text)
        item.child("price").setValue(price.text)
        item.child("bestOffer").setValue(on)
        item.child("description").setValue(descriptionField.text)
        item.child("category").setValue(itemCategory)
        item.child("imageURL").setValue(downloadURL?.absoluteString)
    }

    func checkCondition() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            itemCondition = "New"
        case 1:
            itemCondition = "Like New"
        case 2:
            itemCondition = "Used"
        case 3:
            itemCondition = "N/A"
        default:
            NSLog("Error")
        }
    }
    @IBAction func imgPressed(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("Photo Library is not available")
            return
        } else {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imgPicker.sourceType = .photoLibrary
            imgPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] {
            itemImage.setImage(img as? UIImage, for: UIControlState.normal)
            itemImage.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        }
        picker.dismiss(animated: true, completion: nil)
        uploadImage()
    }
    
    func uploadImage() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgName = NSUUID().uuidString
        let imageData = UIImageJPEGRepresentation((itemImage.imageView?.image)!, 0.1)
        let imageRef = storageRef.child("\(imgName).jpg")
        let uploadTask = imageRef.putData(imageData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            self.downloadURL = metadata.downloadURL()!
            print(self.downloadURL!)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currCategory = categoryArray[indexPath.row]
        if currCategory.accessoryType == .none {
            currCategory.accessoryType = .checkmark
            itemCategory = (currCategory.textLabel?.text)!
            for category in categoryArray {
                if category != currCategory {
                    category.accessoryType = .none
                }
            }
        } else {
            currCategory.accessoryType = .none
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
