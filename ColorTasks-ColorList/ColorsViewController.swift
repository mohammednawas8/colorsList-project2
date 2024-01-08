//
//  ViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit

class ColorsViewController: UIViewController {

    @IBOutlet var colorsTableView: UITableView!
    
    var selectedColor = colorsList.first {
        didSet {

        }
    }
    
    private struct Constants {
        static let CELL_HEIGHT = CGFloat(integerLiteral: 47)
        static let CELL_IDENTIFIER = "colorCellId"
        static let CELL_NIB_NAME = "ColorTableViewCell"
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
           
        } else {
            
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
    }
}

extension ColorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER, for: indexPath) as! ColorTableViewCell
        cell.colorLabel.text = colorsList[indexPath.row].name
        cell.backgroundColor = colorsList[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedColor = colorsList[indexPath.row]
    }
}

