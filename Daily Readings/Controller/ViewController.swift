//
//  ViewController.swift
//  Daily Readings
//
//  Created by PoGo on 10/25/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let plusPhotoButton: UIButton = {

        let button = UIButton()
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        return tf
        
    }()
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        return tf
        
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        return tf
        
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "church1")
        image.contentMode = .scaleAspectFill
        return image
        
        
    }()
    
    let blackAlphaImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.black
        image.alpha = 0.4
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let lineSeparator1: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return line1
    }()
    
    let lineSeparator2: UIView = {
        let line2 = UIView()
        line2.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return line2
    }()
    
    let lineSeparator3: UIView = {
        let line3 = UIView()
        line3.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return line3
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        view.addSubview(blackAlphaImage)
        view.addSubview(plusPhotoButton)
        
        blackAlphaImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupInputFields()
        
    }
    
    func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        view.addSubview(lineSeparator1)
        view.addSubview(lineSeparator2)
        view.addSubview(lineSeparator3)
        view.addSubview(signUpButton)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 150)
        
        lineSeparator1.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        
        lineSeparator2.anchor(top: userNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        
        lineSeparator3.anchor(top: passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        
        signUpButton.anchor(top: lineSeparator3.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
        
    }
    
    
}

