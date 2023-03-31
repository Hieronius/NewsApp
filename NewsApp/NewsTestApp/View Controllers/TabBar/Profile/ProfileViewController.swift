//
//  ProfileViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var profileNameField: UITextField!
    @IBOutlet private weak var profileEmailFeild: UITextField!
    
    // MARK: - Private Properties
    
    private let backgroundColorForViewControllersFromFigma = UIColor(displayP3Red: 242,
                                                                     green: 242,
                                                                     blue: 246,
                                                                     alpha: 1)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImageView()
        setupProfileNameField()
        setupProfileEmailField()
    }
    
    // MARK: - IBActions
    
    @IBAction private func logOutButtonPressed(_ sender: Any) {
        let ac = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Отмена", style: .default))
        ac.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { action in
            self.performSegue(withIdentifier: "doUnwind", sender: self)
        }))
        self.present(ac, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupProfileImageView() {
        profileImageView.image = TestUser.testUser.userTestPhoto
        profileImageView.layer.cornerRadius = 50
    }
    
    private func setupProfileNameField() {
        profileNameField.text = " \(TestUser.testUser.userName)"
        profileNameField.layer.cornerRadius = 20
        profileNameField.layer.borderWidth = 0.5
        profileNameField.layer.borderColor = backgroundColorForViewControllersFromFigma.cgColor
        profileNameField.layer.masksToBounds = true
    }
    
    private func setupProfileEmailField() {
        profileEmailFeild.text = " \(TestUser.testUser.userLogin)"
        profileEmailFeild.layer.cornerRadius = 20
        profileEmailFeild.layer.borderWidth = 0.5
        profileEmailFeild.layer.borderColor = backgroundColorForViewControllersFromFigma.cgColor
        profileEmailFeild.layer.masksToBounds = true
    }
    
}
