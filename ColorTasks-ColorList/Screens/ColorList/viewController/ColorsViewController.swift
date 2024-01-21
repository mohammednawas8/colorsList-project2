//
//  ViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

// TODO: Fix the bug
import UIKit

class ColorsViewController: UIViewController {
    
    @IBOutlet var colorsTableView: UITableView!
    @IBOutlet var colorDescriptionView: ColorDescriptionView!
    var editButton: UIButton!
    var toolbarCompletionView : UIView!
    var selectedColorIndices = [Int]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let colorOrder = ColorOrder()

    var colorList = [Color]() {
        didSet {
            colorsTableView.reloadData()
            colorOrder.order = colorList.extractIds()
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
        selectedColor = colorList.first
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
        colorList = getOrderedColorList()
        selectedColor = selectedColor == nil ? colorList.first ?? nil : selectedColor
    }
    
    func getOrderedColorList() -> [Color] {
        let colorOrder = colorOrder.order ?? []
          let unorderedColors = try? context.fetch(Color.fetchRequest())
          var orderedColors = [Color]()
          for id in colorOrder {
              if let color = unorderedColors?.first(where: { $0.id == id }) {
                  orderedColors.append(color)
              }
          }
          return orderedColors
    }
    
    func showAppropriateView(){
        if UIDevice.current.orientation.isPortrait {
            portraitView()
        } else {
            landscapeView()
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
        colorsTableView.setEditing(true, animated: true)
    }
    
    func editModeOff(){
        editButton.setTitle("Edit", for: .normal)
        navigationController?.isToolbarHidden = true
        colorsTableView.allowsMultipleSelectionDuringEditing = false
        colorsTableView.setEditing(false, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        guard let selectedIndices = colorsTableView.indexPathsForSelectedRows else { return }
        var shouldUpdateTheSelectedColor = false
        for indexPath in selectedIndices {
            if !shouldUpdateTheSelectedColor {
                shouldUpdateTheSelectedColor = colorList[indexPath.row] == selectedColor // true when the current selected color is in the deletion list.
            }
            context.delete(colorList[indexPath.row])
        }
        do {
            try context.save()
            fetchColors()
        } catch {
            present(createAlertController(message: "Can't delete color"), animated: true)
            return
        }
        if shouldUpdateTheSelectedColor {
            selectedColor = colorList.first
        }
    }
    
    @objc func addButtonTapped() {
        guard let addViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ADD_VC_ID) as? AddColorViewController else { return }
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
    }
}

extension ColorsViewController: AddColorDelegate {
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
        cell.set(color: colorList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isInEditMode {
            selectedColor = colorList[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isInEditMode
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    private func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
        var colorListCopy = colorList
        guard sourceIndex != destinationIndex else { return }
        let movedColor = colorListCopy.remove(at: sourceIndex)
        colorListCopy.insert(movedColor, at: destinationIndex)
        colorList = colorListCopy
    }
}
