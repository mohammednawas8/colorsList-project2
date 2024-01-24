//
//  AddColorViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 11/01/2024.
//

import UIKit

protocol AddColorViewControllerDelegate: AnyObject {
    func didAddNewColor(color: Color)
}

class AddColorViewController: BaseUIViewController {
    
    @IBOutlet private var colorDescriptionTextView: UITextView!
    @IBOutlet private var colorButton: UIButton!
    @IBOutlet private var titleTextFieldView: ColorTextFieldView!
    @IBOutlet private var descriptionTextView: UITextView!
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let uiColorPicker = UIColorPickerViewController()
        uiColorPicker.delegate = self
        uiColorPicker.title = "Colors"
        uiColorPicker.modalPresentationStyle = .pageSheet
        return uiColorPicker
    }()
    
    var selectedColor = UIColor.orange {
        didSet {
            colorButton.backgroundColor = selectedColor
        }
    }
    
    weak var delegate: AddColorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTextView()
    }
    
    func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        title = "New Color"
        navigationBar.addBottomBoder(height: 1)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancelButton.tintColor = .black
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
    
    func configureTextView() {
        colorDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        colorDescriptionTextView.layer.borderWidth = 1
        colorDescriptionTextView.layer.cornerRadius = 20
        colorDescriptionTextView.textContainer.lineFragmentPadding = 15
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func colorButtonTapped(_ sender: Any) {
        present(colorPicker, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let savedColor = ColorDataManager.shared.saveColor(
            name: titleTextFieldView.textField.text,
            description: descriptionTextView.text,
            value: selectedColor.toHexString()
        )
        if let savedColor {
            dismiss(animated: true)
            delegate?.didAddNewColor(color: savedColor)
        } else {
            presentErrorAlert(title: "Saving error", message: "Something went wrong !")
        }
    }
}

extension AddColorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedColor = color
    }
}
