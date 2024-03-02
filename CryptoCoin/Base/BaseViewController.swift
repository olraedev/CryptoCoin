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
        
        if NetworkCheck.shared.isConnected {
            print("인터넷 연결이 원활합니다")
        } else {
            print("인터넷 연결이 없습니다")
            showAlert(title: "네트워크에 접속할 수 없습니다", message: "연결 상태를 확인해주세요") {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            }
        }
        
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
