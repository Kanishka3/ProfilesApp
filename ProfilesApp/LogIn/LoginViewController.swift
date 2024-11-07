//
//  ViewController.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 06/11/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let displayView = LoginView()
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        addTapGestureToDismissKeyboard()
        setAction()
    }
    
    func createViews() {
        view.addSubview(displayView)
        displayView.translatesAutoresizingMaskIntoConstraints = false
        displayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        displayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.phoneWidth * 0.3).isActive = true
        displayView.topAnchor.constraint(equalTo: view.topAnchor, constant: GlobalConstants.phoneHeight * 0.3).isActive = true
    }
    
    func setAction() {
        displayView.didTapButton = { [weak self] in
            guard let self else { return }
            viewModel.login(for: displayView.text) { [weak self] isSuccess in
                guard let self else { return }
                DispatchQueue.main.async {
                    if isSuccess {
                        let viewController = OTPViewController(phoneNumber: self.displayView.text)
                        viewController.phoneNumber = self.displayView.text
                        self.navigationController?.pushViewController(viewController, animated: true)
                    } else {
                        ToastManager.shared.showToast(GlobalConstants.loginFailed)
                    }
                }
            }
        }
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        view.endEditing(true)
    }
}

private class LoginView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let textField = NumberOTPField()
    private let continueButton =  UIButton()
    var didTapButton: (()->Void)?
    
    var text: String {
        (textField.textfield.text ?? "") + (textField.textfield1.text ?? "")
    }
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        createViews()
        setData()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(continueButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        continueButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        didTapButton?()
    }
    
    private func setData() {
        subtitleLabel.text = GlobalConstants.loginSubtitle
        titleLabel.text = GlobalConstants.loginTitle
    }
    
    private func configureUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        continueButton.setStandardStyle()
    }
}

class NumberOTPField: UIStackView, UITextFieldDelegate {
    let textfield = UITextField()
    let textfield1 = UITextField()
    private let countryCodePicker = UIPickerView()
    private let countryCodes = ["+91", "+1"]
    
    
    init() {
        super.init(frame: .zero)
        addArrangedSubview(textfield)
        addArrangedSubview(textfield1)
        textfield.widthAnchor.constraint(equalToConstant: 60).isActive = true
        textfield1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        textfield1.delegate = self
        textfield.text = countryCodes[0] // default to +91
        
        countryCodePicker.delegate = self
        countryCodePicker.dataSource = self
        textfield.inputView = countryCodePicker
        
        
        [textfield, textfield1].forEach {
            $0.setStandardUI()
            $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        spacing = 10
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // set limit for 10 characters
        return (textField.text ?? "").count + string.count <= 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NumberOTPField: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int { countryCodes.count }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return countryCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        textfield.text = countryCodes[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
