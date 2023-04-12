//
//  ResetViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

final class ResetViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var resetEmailTextField: UITextField!
    @IBOutlet private weak var resetPasswordButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - IBActions
    
    @IBAction private func resetPasswordButtonPressed(_ sender: Any) {
        if resetEmailTextField.text?.isEmpty == true {
            let ac = UIAlertController(title: "Ошибка", message: "Заполните пустые поля", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
        } else if isValidEmail(resetEmailTextField.text!) == false {
            let ac = UIAlertController(title: "Ошибка", message: "Проверьте правильность ввода почты", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
        } else {
            let ac = UIAlertController(title: "Успешно", message: "Инструкция по сбросу пароля придет Вам на почту", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            resetEmailTextField.text = ""
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupResetEmailTextField()
        setupResetPasswordButton()
    }
    
    private func setupResetEmailTextField() {
        resetEmailTextField.layer.cornerRadius = 20
        resetEmailTextField.layer.borderWidth = 0.5
        resetEmailTextField.layer.borderColor = UIColor.white.cgColor
        resetEmailTextField.layer.masksToBounds = true
    }
    
    private func setupResetPasswordButton() {
        resetPasswordButton.layer.cornerRadius = 20
    }
    
}
