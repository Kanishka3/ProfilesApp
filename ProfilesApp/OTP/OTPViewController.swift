//
//  OTPViewController.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 06/11/24.
//

import UIKit

class OTPViewController: UIViewController {
    private var otpView: OTPView

    var phoneNumber = ""
    
    private let viewModel = OTPViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        addTapGestureToDismissKeyboard()
    }
    
    
    init(phoneNumber: String = "") {
        self.phoneNumber = phoneNumber
        otpView = OTPView(phoneNumber: phoneNumber)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        view.backgroundColor = .white
        view.addSubview(otpView)
        otpView.didTapButton = { [weak self] in
            guard let self else { return }
            viewModel.fetchApi(for: phoneNumber,
                               otp: otpView.text) { token, isSuccess in
                DispatchQueue.main.async {
                    if let token, isSuccess {
                        self.navigationController?.pushViewController(MainTabBarController(token: token), animated: true)
                    } else {
                        ToastManager.shared.showToast(GlobalConstants.otpFailed)
                    }
                }
            }
        }
        otpView.translatesAutoresizingMaskIntoConstraints = false
        otpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        otpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.phoneWidth * 0.3).isActive = true
        otpView.topAnchor.constraint(equalTo: view.topAnchor, constant: GlobalConstants.phoneHeight * 0.3).isActive = true

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

class OTPView: UIView, UITextFieldDelegate {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let textfield = UITextField()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    private let button = UIButton()
    
    var text: String {
        textfield.text ?? ""
    }

    var didTapButton: (()->Void)?
    var phoneNumber = ""
    
    init(phoneNumber: String) {
        super.init(frame: .zero)
        self.phoneNumber = phoneNumber
        createViews()
        configureUI()
        setData(phoneNumber: phoneNumber)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textfield)
        stackView.addArrangedSubview(button)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        textfield.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textfield.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        textfield.setStandardUI()
    }
    
    func setData(phoneNumber: String) {
        titleLabel.text = GlobalConstants.otpTitle
        subtitleLabel.text = phoneNumber
    }
    
    func configureUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        textfield.delegate = self
        button.setStandardStyle()
    }
    
    @objc private func buttonTapped() {
        didTapButton?()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // set limit for 10 characters
        return (textField.text ?? "").count + string.count <= 4
    }
    
}
