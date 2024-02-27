//
//  BaseViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    let profileImageView = RoundImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(navigationTitle: "")
    }
    
    func configureView(navigationTitle: String) {
        view.backgroundColor = Design.Color.customWhite.fill
        
        profileImageView.image = UIImage.profile
        profileImageView.layer.borderColor = Design.Color.customPurple.fill.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        navigationItem.title = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
