//
//  AddColorViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 11/01/2024.
//

import UIKit

class AddColorViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var colorDescriptionTextView: UITextView!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var titleTextField: ColorTextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedColor = UIColor.orange {
        didSet {
            colorButton.configuration?.baseBackgroundColor = selectedColor
        }
    }
    
    weak var delegate: AddColorDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBars()
        configureNavigationBar()
        configureTextView()
    }
    
    func hideBars() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func configureNavigationBar() {
        let titleAttributes:[NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
        ]
        navigationBar.titleTextAttributes = titleAttributes
        
    }
    
    func configureTextView() {
        colorDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        colorDescriptionTextView.layer.borderWidth = 1
        colorDescriptionTextView.layer.cornerRadius = 20
        colorDescriptionTextView.textContainer.lineFragmentPadding = 15
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func colorButtonTapped(_ sender: Any) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.title = "Colors"
        colorPicker.modalPresentationStyle = .pageSheet
        present(colorPicker, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        // TODO: Save a new color using Core Data
        let color = Color(context: context)
        color.name = titleTextField.textField.text
        color.colorDescription = descriptionTextView.text
        color.value = selectedColor.toHexString()
        color.id = UUID().uuidString
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
            delegate?.didAddNewColor(color: color)
            print("Saved new color successfully")
        } catch {
            present(createAlertController(message: "Something went wrong while saving the color"), animated: true)
            print("Error while saving a color \(error)")
        }
    }
}
