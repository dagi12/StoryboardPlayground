//
//  LargeViewController.swift
//  StoryboardPlayground
//
//  Created by Eryk Mariankowski on 10.01.2019.
//  Copyright © 2019 Eryk Mariankowski. All rights reserved.
//

import UIKit
import Crashlytics
import EPSignature

class LargeViewController: UIViewController, EPSignatureDelegate {

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if #available(iOS 11.0, *) {
//            navigationItem.largeTitleDisplayMode = .always
//            navigationController?.navigationBar.prefersLargeTitles = true
//        }
//    }

    @IBAction func onCrashTapped(_ sender: Any) {
        Crashlytics.sharedInstance().crash()
    }

    @IBAction func onSignTapped(_ sender: Any) {
        let vc = EPSignatureViewController(signatureDelegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}
