//
//  ViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit

class ColorsViewController: UIViewController {

    @IBOutlet var colorsTableView: UITableView!
    @IBOutlet var colorDescriptionView: ColorDescriptionView!
    var editButton: UIButton!
    var toolbarCompletionView : UIView!
    var selectedColorIndices = [Int]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var colorsList = [Color]() {
        didSet {
            colorsTableView.reloadData()
        }
    }
    
    var selectedColor: Color? {
        didSet {
           updateDescriptionView()
        }
    }
    
    var isInEditMode = false {
        didSet{
            if isInEditMode {
                editModeOn()
            } else {
                editModeOff()
            }
        }
    }
    
    struct Constants {
        static let CELL_HEIGHT = CGFloat(integerLiteral: 47)
        static let CELL_IDENTIFIER = "colorCellId"
        static let CELL_NIB_NAME = "ColorTableViewCell"
        static let ADD_VC_ID = "AddViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedColor = colorsList.first
        configureViews()
        showAppropriateView()
        configureNavigationBar()
        fetchColors()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        showAppropriateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        if isInEditMode {
            editModeOn()
        }
    }
    
    func fetchColors() {
        colorsList = try! context.fetch(Color.fetchRequest())
        selectedColor = selectedColor === nil ? colorsList.first ?? nil : selectedColor
    }
    
    func showAppropriateView(){
        if UIDevice.current.orientation.isPortrait {
            navigationController?.navigationBar.isHidden = false
        } else {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    
    func portraitView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
        title = "Colors"
       
    }
    
    func landscapeView(){
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureViews(){
        colorsTableView.delegate = self
        colorsTableView.dataSource = self
        colorsTableView.dragDelegate = self
        colorsTableView.dropDelegate = self
        colorsTableView.dragInteractionEnabled = true
        let cellNib = UINib(nibName: Constants.CELL_NIB_NAME, bundle: nil) // main bundle
        colorsTableView.register(cellNib, forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        
        updateDescriptionView()
    }
    
    func updateDescriptionView(){
        if let selectedColor {
            guard let selectedColorHex = selectedColor.value else { return }
            if let selectedUiColor = UIColor(hex: selectedColorHex) {
                colorDescriptionView.setDescription(description: selectedColor.colorDescription ?? "")
                colorDescriptionView.setBackgroundColor(color: selectedUiColor)
            }
        } else {
            colorDescriptionView.setBackgroundColor(color: .white)
            colorDescriptionView.descriptionLabel.text = ""
        }
    }
    
    func configureNavigationBar(){
        editButton = UIButton(type: .custom)
        editButton.setTitle("Edit", for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        editButton.setTitleColor(.black, for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor,constant: -15),
            editButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            editButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -7),
        ])
    }
    
    @objc func editButtonTapped(){
        isInEditMode = !isInEditMode
    }
    
    func editModeOn(){
        editButton.setTitle("Done", for: .normal)
        
        guard let toolbar = navigationController?.toolbar else { return }
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .black
        let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        deleteButton.tintColor = .red
        toolbarItems = [deleteButton,spacer,addButton]
        
        toolbar.backgroundColor = .white
        
        navigationController?.isToolbarHidden = false
        colorsTableView.allowsMultipleSelectionDuringEditing = true
        colorsTableView.isEditing = true
    }
    
    func editModeOff(){
        editButton.setTitle("Edit", for: .normal)
        navigationController?.isToolbarHidden = true
        colorsTableView.allowsMultipleSelectionDuringEditing = false
        colorsTableView.isEditing = false
    }
    
    @objc func deleteButtonTapped() {
        guard let selectedIndices = colorsTableView.indexPathsForSelectedRows else { return }
        for indexPath in selectedIndices {
            context.delete(colorsList[indexPath.row])
            do {
                try context.save()
            } catch {
                present(createAlertController(message: "Can't delete color"), animated: true)
                return
            }
        }
        fetchColors()
        colorsTableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        guard let addViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ADD_VC_ID) as? AddColorViewController else { return }
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
    }
}
