//
//  ViewController.swift
//  OktaIntergration
//
//  Created by Saurabh Bisht on 28/03/24.
//

import UIKit
import OktaOidc

class ViewController: UIViewController {
    @IBOutlet weak var token: UILabel!
    var oktaOidc: OktaOidc?
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let config = try OktaOidcConfig(fromPlist: "OktaConfig")
            oktaOidc = try OktaOidc(configuration: config)
        } catch {
            // Handle error
        }
    }
    
    @IBAction func login(_ sender: Any) {
        login()
    }
    
    func login() {
        oktaOidc?.signInWithBrowser(from: self) { [weak self] (state, error) in
            guard let self = self else { return }
            if let error = error {
                // Handle authentication error
                return
            }

            guard let accessToken = state?.accessToken else {
                // Handle missing access token
                return
            }
            token.text = accessToken
            print(accessToken)

            // Use the access token to call your resource server
        }
    }

    
    
}

