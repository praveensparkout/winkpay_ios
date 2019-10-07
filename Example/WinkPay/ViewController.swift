//
//  ViewController.swift
//  WinkPay
//
//  Created by sathishvgs on 09/29/2019.
//  Copyright (c) 2019 sathishvgs. All rights reserved.
//

import UIKit
import WinkPay

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let appWindow = appDelegate.window else { return }
        WinkPay.initialize(with: appWindow, userId: "8056359277", clientId: "5d89e3953226963b24a5dbfe")
        WinkPay.shared.presentManager()
    }

}

