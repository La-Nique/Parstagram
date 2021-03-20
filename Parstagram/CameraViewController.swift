//
//  CameraViewController.swift
//  Parstagram
//
//  Created by ピタソン・ラニク on 3/19/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { // UIImage... will give you user photos

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        /*
        //we created a table on Parse called "Pets":
        let pet = PFObject(className: "Pets")
        
        //this new table has columns of each element, lol:
        pet["name"] = "Spencer" //
        pet["weight"] = 50
        pet["owner"] = PFUser.current()! // owner becomes a pointer and it is linked with the currently logged account.
        pet.saveInBackground{(success, error) in
            if success {
                print("saved!")
            } else {
                print("error!")
            }
         */
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData() //taking the scaled image and saving as a png
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground{(success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self // once user is done taking a photo, it'll tell what they took
        picker.allowsEditing = true // allows for a secondary screen so user can finish up
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){ //if your camera is available, let's use that... .camera is an enum 
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 400, height: 400) // import Alamo, we scaled the size of the image
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


