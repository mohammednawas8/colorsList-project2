//
//  ViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit

class ColorsViewController: UIViewController {
    
    var tableView: UITableView!
    var descriptionView: UIView!
    var descriptionHeaderLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var portraitConstraints = [NSLayoutConstraint]()
    var landscapeConstraints = [NSLayoutConstraint]()
    
    var selectedColor = colorsList.first {
        didSet {
            descriptionView.backgroundColor = selectedColor?.color
            descriptionLabel.text = selectedColor?.description
        }
    }
    
    private struct Constants {
        static let CELL_HEIGHT = CGFloat(integerLiteral: 47)
        static let CELL_IDENTIFIER = "colorCellId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        showAppropriateView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        showAppropriateView()
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
        print(landscapeConstraints.count)
        activatePortraitModeConstraints()
        view.layoutIfNeeded()
    }
    
    func landscapeView(){
        navigationController?.isNavigationBarHidden = true
        activateLandscapeModeConstraints()
        view.layoutIfNeeded()
    }
    
    func configureViews(){
        tableView = UITableView()
        tableView.register(ColorCellTableViewCell.self, forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.CELL_HEIGHT
        
        descriptionView = UIView()
        descriptionView.backgroundColor = selectedColor?.color
        view.addSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionHeaderLabel = UILabel()
        descriptionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionHeaderLabel.text = "Description"
        descriptionHeaderLabel.textColor = .white
        descriptionHeaderLabel.font = .systemFont(ofSize: 24, weight: .bold)
        descriptionView.addSubview(descriptionHeaderLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = selectedColor?.description
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionView.addSubview(descriptionLabel)

    }
    
    func activatePortraitModeConstraints(){
        NSLayoutConstraint.deactivate(landscapeConstraints)
        portraitConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            descriptionHeaderLabel.leadingAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.leadingAnchor),
            descriptionHeaderLabel.topAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(portraitConstraints)
    }
    
    func activateLandscapeModeConstraints() {
        NSLayoutConstraint.deactivate(portraitConstraints)
        landscapeConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            descriptionView.topAnchor.constraint(equalTo: view.topAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),

            descriptionHeaderLabel.leadingAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.leadingAnchor),
            descriptionHeaderLabel.topAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.layoutMarginsGuide.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(landscapeConstraints)
    }
}

extension ColorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER)
            as! ColorCellTableViewCell
        cell.set(colorInfo: colorsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedColor = colorsList[indexPath.row]
    }
}

