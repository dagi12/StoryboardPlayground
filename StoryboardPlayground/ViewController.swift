//
//  ViewController.swift
//  StoryboardPlayground
//
//  Created by Eryk Mariankowski on 07.01.2019.
//  Copyright © 2019 Eryk Mariankowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag)

        if let safeNextResponder = nextResponder {
            // Found next responder, so set it
            safeNextResponder.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }

        return false
    }


}

