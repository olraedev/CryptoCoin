//
//  BaseViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    let profileImageView = RoundImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(navigationTitle: "")
    }
    
    func configureView(navigationTitle: String) {
        view.backgroundColor = Color.customWhite
        
        profileImageView.image = UIImage.profile
        profileImageView.layer.borderColor = Color.customPurple.cgColor
        profileImageView.layer.borderWidth = 1
        
        navigationItem.title = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
