//
//  ViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit

class ColorsViewController: BaseUIViewController {
    
    @IBOutlet private var colorsTableView: UITableView!
    @IBOutlet private var colorDescriptionView: ColorDescriptionView!
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        return button
    }()
    
    var selectedColorIndices = [Int]()
    
    let colorOrder = ColorOrder()
    
    var colorList = [Color]() {
        didSet {
            colorsTableView.reloadData()
            ColorOrder.order = colorList.extractIds()
        }
    }
    
    var selectedColor: Color? {
        didSet {
            updateDescriptionView()
        }
    }
    
    var isEditMode = false {
        didSet {
            editModeChange()
        }
    }
    
    struct Constants {
        static let CELL_IDENTIFIER = "colorCellId"
        static let CELL_NIB_NAME = "ColorTableViewCell"
        static let ADD_VC_ID = "AddViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedColor = colorList.first
        configureViews()
        configureNavigationBar()
        configureToolbar()
        fetchColors()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        navigationController?.isNavigationBarHidden = !UIDevice.current.orientation.isPortrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        if isEditMode {
            editModeChange()
        }
    }
    
    func fetchColors() {
        colorList = ColorDataManager.shared.getOrderedColorList()
        selectedColor = selectedColor == nil ? colorList.first ?? nil : selectedColor
    }
    
    func configureViews() {
        configureTableView()
        updateDescriptionView()
    }
    
    func configureTableView() {
        colorsTableView.delegate = self
        colorsTableView.dataSource = self
        let cellNib = UINib(nibName: Constants.CELL_NIB_NAME, bundle: nil)
        colorsTableView.register(cellNib, forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
    }
    
    func updateDescriptionView() {
        guard let selectedColorHex = selectedColor?.value else { return }
        guard let selectedUiColor = UIColor(hex: selectedColorHex) else { return }
        colorDescriptionView.setDescription(description: selectedColor?.colorDescription ?? "")
        colorDescriptionView.setBackgroundColor(color: selectedUiColor)
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
    }
    
    func configureToolbar() {
        guard let toolbar = navigationController?.toolbar else { return }
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .black
        let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        deleteButton.tintColor = .red
        toolbarItems = [deleteButton,spacer,addButton]
        toolbar.backgroundColor = .white
    }
    
    @objc func editButtonTapped() {
        isEditMode = !isEditMode
    }
    
    @objc func editModeChange() {
        let title = isEditMode ? "Done" : "Edit"
        editButton.title = title
        navigationController?.isToolbarHidden = !isEditMode
        colorsTableView.allowsMultipleSelectionDuringEditing = isEditMode
        colorsTableView.setEditing(isEditMode, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        guard let selectedIndices = colorsTableView.indexPathsForSelectedRows else { return }
        let colorDeletionList = selectedIndices.map { colorList[$0.row] }
        let result = ColorDataManager.shared.deleteColors(list: colorDeletionList)
        if result {
            fetchColors()
        } else {
            presentErrorAlert(title: "Delete error", message: "Something went wrong")
        }
        if colorDeletionList.contains(where: { selectedColor?.id == $0.id }) {
            self.selectedColor = colorList.first
        }
    }
    // Present as full screen not working
    @objc func addButtonTapped() {
        guard let addColorViewController: AddColorViewController = instantiateViewController(identifier: Constants.ADD_VC_ID) else { return }
        addColorViewController.delegate = self
        let navController = UINavigationController(rootViewController: addColorViewController)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

extension ColorsViewController: AddColorViewControllerDelegate {
    func didAddNewColor(color: Color) {
        colorList.append(color)
    }
}

extension ColorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER, for: indexPath) as! ColorTableViewCell
        cell.configureCell(model: colorList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditMode {
            selectedColor = colorList[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isEditMode
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    private func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        let movedColor = colorList.remove(at: sourceIndex)
        colorList.insert(movedColor, at: destinationIndex)
    }
}
