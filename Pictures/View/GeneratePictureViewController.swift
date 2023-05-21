//
//  GeneratePictureViewController.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

class GeneratePictureViewController: UIViewController, GeneratePictureViewModelDelegate {
    
    private static let keyboardAimationDuration = 0.5
    private static let submitButtonTextCommon = "GeneratePicture.Button.Submit".localized
    private static let submitButtonTextLoading = "GeneratePicture.Button.Loading".localized
    
    @objc let viewModel = GeneratePictureViewModel()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "GeneratePicture.TextField.Placeholder".localized
        textField.accessibilityIdentifier = "GeneratePicture.TextField"
        textField.addTarget(
            self,
            action: #selector(textFieldValueChanged(_:)),
            for: .editingChanged
        )
        return textField
    }()
    
    private let addToFavouritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GeneratePicture.Button.AddToFavourites".localized, for: .normal)
        button.accessibilityIdentifier = "GeneratePicture.Button.AddToFavourites"
        button.addTarget(
            self,
            action: #selector(addToFavouritesButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(submitButtonTextCommon, for: .normal)
        button.accessibilityIdentifier = "GeneratePicture.Button.Submit"
        button.addTarget(
            self,
            action: #selector(submitButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private let submitButtonBottomConstraintConstant = -30
    private var submitButtonBottomConstraint: NSLayoutConstraint!
    private var imageTopConstraint: NSLayoutConstraint!
    
    private var observations: Set<NSKeyValueObservation> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        setupStyling()
        setupObservations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.title = "GeneratePicture.Title".localized
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(submitButton)
        view.addSubview(addToFavouritesButton)
    }
    
    private func setupSubviews() {
        imageView.image = viewModel.picture?.picture
        textField.text = viewModel.query
        submitButton.isEnabled = viewModel.submitEnabled
        addToFavouritesButton.isHidden = !viewModel.addToFavouritesEnabled
        
        textField.delegate = self
    }
    
    private func setupConstraints() {
        setupImageViewConstraints()
        setupTextFieldConstraints()
        setupSubmitButtonConstraints()
        setupAddToFavouritesButtonConstraints()
    }
    
    private func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageTopConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: view.safeAreaLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 30
        )
        imageTopConstraint.isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .leading,
            relatedBy: .greaterThanOrEqual,
            toItem: view.safeAreaLayoutGuide,
            attribute: .leading,
            multiplier: 1,
            constant: 20
        ).isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .trailing,
            relatedBy: .greaterThanOrEqual,
            toItem: view.safeAreaLayoutGuide,
            attribute: .trailing,
            multiplier: 1,
            constant: -20
        ).isActive = true
        
        NSLayoutConstraint(
            item: imageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .height,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }
    
    private func setupTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: textField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: textField,
            attribute: .top,
            relatedBy: .equal,
            toItem: addToFavouritesButton,
            attribute: .bottom,
            multiplier: 1,
            constant: 50
        ).isActive = true
        
        NSLayoutConstraint(
            item: textField,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: submitButton,
            attribute: .top,
            multiplier: 1,
            constant: -50
        ).isActive = true
        
        NSLayoutConstraint(
            item: textField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.7,
            constant: 0
        ).isActive = true
    }
    
    private func setupSubmitButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: submitButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        submitButtonBottomConstraint = NSLayoutConstraint(
            item: submitButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .bottom,
            multiplier: 1,
            constant: CGFloat(submitButtonBottomConstraintConstant)
        )
        submitButtonBottomConstraint.isActive = true
    }
    
    private func setupAddToFavouritesButtonConstraints() {
        addToFavouritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: addToFavouritesButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: addToFavouritesButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .bottom,
            multiplier: 1,
            constant: 50
        ).isActive = true
        
        NSLayoutConstraint(
            item: addToFavouritesButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: addToFavouritesButton,
            attribute: .width,
            multiplier: 1,
            constant: 100
        ).isActive = true
        
        NSLayoutConstraint(
            item: addToFavouritesButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: addToFavouritesButton,
            attribute: .height,
            multiplier: 1,
            constant: 100
        ).isActive = true
    }
    
    private func setupStyling() {
        view.backgroundColor = .white
    }
    
    private func setupObservations() {
        observations.insert(observe(\.viewModel.picture, options: [.new]) { [weak self] object, change in
            DispatchQueue.main.async {
                guard let newValue = change.newValue else { return }
                self?.imageView.image = newValue?.picture
            }
        })
        observations.insert(observe(\.viewModel.submitEnabled, options: [.new]) { [weak self] object, change in
            DispatchQueue.main.async {
                guard let newValue = change.newValue else { return }
                self?.submitButton.isEnabled = newValue
            }
        })
        observations.insert(observe(\.viewModel.addToFavouritesEnabled, options: [.new]) { [weak self] object, change in
            DispatchQueue.main.async {
                guard let newValue = change.newValue else { return }
                self?.addToFavouritesButton.isHidden = !newValue
            }
        })
        observations.insert(observe(\.viewModel.loadingInProgress, options: [.new]) { [weak self] object, change in
            DispatchQueue.main.async {
                guard let newValue = change.newValue else { return }
                self?.handleLoading(inProgress: newValue)
            }
        })
    }
    
    private func handleKeyboardHeight(_ keyboardHeight: CGFloat) {
        submitButtonBottomConstraint.constant = CGFloat(submitButtonBottomConstraintConstant) - keyboardHeight
        imageTopConstraint.isActive = keyboardHeight <= 0
        view.layoutIfNeeded()
    }
    
    private func submit() {
        view.endEditing(true)
        viewModel.submit()
    }
    
    private func handleLoading(inProgress: Bool) {
        if inProgress {
            submitButton.setTitle(Self.submitButtonTextLoading, for: .normal)
        } else {
            submitButton.setTitle(Self.submitButtonTextCommon, for: .normal)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        let keyboardHeight = keyboardSize?.height
        handleKeyboardHeight(keyboardHeight ?? 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        handleKeyboardHeight(0)
    }
    
    @objc private func submitButtonPressed(_ keyboardHeight: CGFloat) {
        submit()
    }
    
    @objc private func addToFavouritesButtonPressed() {
        viewModel.addToFavourites()
    }
    
    @objc private func textFieldValueChanged(_ textField: UITextField) {
        viewModel.query = textField.text ?? ""
    }
    
    deinit {
        observations.forEach { $0.invalidate() }
    }
}

extension GeneratePictureViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: Self.keyboardAimationDuration) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        }
        
        UIView.animate(withDuration: Self.keyboardAimationDuration) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
        
        view.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submit()
        return true
    }
}
