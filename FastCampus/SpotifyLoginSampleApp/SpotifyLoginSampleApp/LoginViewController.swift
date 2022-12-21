//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 제임스 on 2022/11/11.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController:UIViewController{
    @IBOutlet weak var emialLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emialLoginButton, googleLoginButton, appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
        //google sign in
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationview 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func emailLoginButtonTapped(_ sender: Any) {
    }
    @IBAction func appleLoginButtonTapped(_ sender: Any) {
    }
}
