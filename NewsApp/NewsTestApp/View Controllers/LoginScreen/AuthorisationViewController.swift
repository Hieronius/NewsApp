//
//  ViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

final class AuthorisationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var authorisationEmailTextField: UITextField!
    @IBOutlet private weak var authorisationPasswordTextField: UITextField!
    @IBOutlet private weak var authorisationLogInButton: UIButton!
    
    // MARK: - Private Properties
    
    private var isAuthorisationLogAndPasswordTextFieldsIsEmpty: Bool {
        authorisationEmailTextField.text?.isEmpty == true ||
        authorisationPasswordTextField.text?.isEmpty == true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAuthorisationEmailTextField()
        setupAuthorisationPasswordTextField()
        setupAuthorisationLogInButton()
    }
    
    // MARK: - IBActions
    
    @IBAction private func authorisationlogInButtonPressed(_ sender: Any) {
        if isAuthorisationLogAndPasswordTextFieldsIsEmpty {
            let ac = UIAlertController(title: "Ошибка", message: "Заполните пустые поля", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)

        } else if isValidEmail(authorisationEmailTextField.text!) == false {
            let ac = UIAlertController(title: "Ошибка", message: "Проверьте правильность ввода почты", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)

        } else if authorisationEmailTextField.text == TestUser.shared.testUser.userLogin && authorisationPasswordTextField.text == TestUser.shared.testUser.userPassword {
                performSegue(withIdentifier: "TabBarSegue", sender: sender)

        } else {
            let ac = UIAlertController(title: "Ошибка", message: "Указан неправильный логин или пароль", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction private func toRegistrationButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ShowRegistration", sender: sender)
    }
    
    @IBAction private func toResetPasswordButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showReset", sender: sender)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }
    
    // MARK: - Private Methods
    
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
    
}

