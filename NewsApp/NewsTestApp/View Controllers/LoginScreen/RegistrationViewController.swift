import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var registrationNameTextField: UITextField!
    @IBOutlet private weak var registrationEmailTextField: UITextField!
    @IBOutlet private weak var registrationPasswordTextField: UITextField!
    @IBOutlet private weak var registrationLogInButton: UIButton!
    
    // MARK: - Private Properties
    
    private var isRegistrationTextFieldsEmpty: Bool {
        registrationNameTextField.text?.isEmpty == true ||
        registrationEmailTextField.text?.isEmpty == true ||
        registrationPasswordTextField.text?.isEmpty == true
    }
    
    private let registrationTextFieldsBorderColor = UIColor.white.cgColor
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - IBActions
    
    @IBAction private func registrationLogInButtonPressed(_ sender: Any) {
        if isRegistrationTextFieldsEmpty {
            let ac = UIAlertController(title: "Ошибка", message: "Заполните пустые поля", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
        } else if isValidEmail(registrationEmailTextField.text!) == false {
            let ac = UIAlertController(title: "Ошибка", message: "Проверьте правильность ввода почты", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
        } else {
            performSegue(withIdentifier: "RegistrationToTabBarSegue", sender: sender)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupRegistrationNameTextField()
        setupRegistrationEmailTextField()
        setupRegistrationPasswordTestField()
        setupRegistrationLogInButton()
    }
    
    private func setupRegistrationNameTextField() {
        registrationNameTextField.layer.cornerRadius = 20
        registrationNameTextField.layer.borderWidth = 0.5
        registrationNameTextField.layer.borderColor = registrationTextFieldsBorderColor
        registrationNameTextField.layer.masksToBounds = true
    }
    
    private func setupRegistrationEmailTextField() {
        registrationEmailTextField.layer.cornerRadius = 20
        registrationEmailTextField.layer.borderWidth = 0.5
        registrationEmailTextField.layer.borderColor = registrationTextFieldsBorderColor
        registrationEmailTextField.layer.masksToBounds = true
    }
    
    private func setupRegistrationPasswordTestField() {
        registrationPasswordTextField.layer.cornerRadius = 20
        registrationPasswordTextField.layer.borderWidth = 0.5
        registrationPasswordTextField.layer.borderColor = registrationTextFieldsBorderColor
        registrationPasswordTextField.layer.masksToBounds = true
    }
    
    private func setupRegistrationLogInButton() {
        registrationLogInButton.layer.cornerRadius = 20
    }
    
}
