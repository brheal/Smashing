//
//  NewGameViewController.swift
//  Smash Smash
//
//  Created by Timothy Barrett on 4/27/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
@IBDesignable
class NewGameViewController: UIViewController {
    @IBInspectable var borderColor:UIColor = UIColor.orangeColor()
    
    @IBOutlet weak var enemyImage: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var playerNameField: UITextField!
    let imagePicker = UIImagePickerController()
    private var enemy:Enemy?
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.layer.cornerRadius = 8.0
        startBtn.layer.borderWidth = 1.0
        startBtn.layer.borderColor = borderColor.CGColor
        playerNameField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startGame" {
            if let destination = segue.destinationViewController as? GameViewController {
                destination.enemy = enemy
            }
        }
    }
    
    @IBAction func takeImagePressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Front) != nil {
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
 
    @IBAction func startGamePressed(sender: AnyObject) {
        if validatePlayerName() {
            self.performSegueWithIdentifier("startGame", sender: nil)
        } else {
            let alertVC = UIAlertController(title: "Ugghhh", message: "You have to enter a player name to play otherwise we won't know who smashed Beiber the most!", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Fine, Fine!", style: .Default, handler: nil)
            alertVC.addAction(okayAction)
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }

}

extension NewGameViewController : UITextFieldDelegate, UINavigationControllerDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validatePlayerName() -> Bool {
        print(playerNameField.text)
        var playerName = playerNameField.text
        if playerName != nil {
            playerName = playerName!.stringByReplacingOccurrencesOfString(" ", withString: "")
            if playerName!.characters.count > 0 {
                Player.currentPlayer.updatePlayerName(withNewName: playerNameField.text!)
                return true
            }
        }
        return false
    }
}

extension NewGameViewController : UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            enemy = Enemy(withImage: pickedImage)
            enemyImage.image = enemy?.getEnemyImage()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
