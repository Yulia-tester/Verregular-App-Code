//
//  HomeViewController.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-16.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Verregular".uppercased()
        label.font = .boldSystemFont(ofSize: 28)
        
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Select verbs".localized, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Train verbs".localized, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private methods


}

