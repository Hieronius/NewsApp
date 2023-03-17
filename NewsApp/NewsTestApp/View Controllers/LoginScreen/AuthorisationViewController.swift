//
//  ViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

class AuthorisationViewController: UIViewController {
    @IBOutlet weak var authorisationEmailTextField: UITextField!
    @IBOutlet weak var authorisationPasswordTextField: UITextField!
    @IBOutlet weak var authorisationLogInButton: UIButton!
    
    private var isAuthorisationLogAndPasswordTextFieldsIsEmpty: Bool {
        authorisationEmailTextField.text?.isEmpty == true ||
        authorisationPasswordTextField.text?.isEmpty == true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAuthorisationEmailTextField()
        setupAuthorisationPasswordTextField()
        setupAuthorisationLogInButton()
    }
    
    private func setupAuthorisationEmailTextField() {
        authorisationEmailTextField.layer.cornerRadius = 20
        authorisationEmailTextField.layer.borderWidth = 0.5
        authorisationEmailTextField.layer.borderColor = UIColor.white.cgColor
        authorisationEmailTextField.layer.masksToBounds = true
    }
    
    private func setupAuthorisationPasswordTextField() {
        authorisationPasswordTextField.layer.cornerRadius = 20
        authorisationPasswordTextField.layer.borderWidth = 0.5
        authorisationPasswordTextField.layer.borderColor = UIColor.white.cgColor
        authorisationPasswordTextField.layer.masksToBounds = true
        authorisationPasswordTextField.textContentType = .oneTimeCode
    }
    
    private func setupAuthorisationLogInButton() {
        authorisationLogInButton.layer.cornerRadius = 20
    }
    
    @IBAction func authorisationlogInButtonPressed(_ sender: Any) {
        if authorisationEmailTextField.text == testUser.userLogin && authorisationPasswordTextField.text == testUser.userPassword {
            performSegue(withIdentifier: "TabBarSegue", sender: sender)

        } else if isAuthorisationLogAndPasswordTextFieldsIsEmpty {
            let ac = UIAlertController(title: "Ошибка", message: "Заполните пустые поля", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)

        } else if isValidEmail(authorisationEmailTextField.text!) == false {
            let ac = UIAlertController(title: "Ошибка", message: "Проверьте правильность ввода почты", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)

        } else {
            let ac = UIAlertController(title: "Ошибка", message: "Указан неправильный логин или пароль", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func toRegistrationButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ShowRegistration", sender: sender)
    }
    
    @IBAction func toResetPasswordButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showReset", sender: sender)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        
    }
}

