//
//  Extensions.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

extension UIView: ConfigureIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UILabel {
    // 검색한 내용이 포함된 UILabel의 텍스트 색깔과 bold 처리
    func changeSearchText(_ searchText: String?) {
        guard let text = self.text else { return }
        guard let searchText else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        
        // 색깔
        attributeString.addAttribute(.foregroundColor, value: Design.Color.customPurple.fill, range: (text.uppercased() as NSString).range(of: searchText.uppercased()))
        attributeString.addAttribute(.foregroundColor, value: Design.Color.customPurple.fill, range: (text.lowercased() as NSString).range(of: searchText.lowercased()))
        
        // bold
        attributeString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: (text.uppercased() as NSString).range(of: searchText.uppercased()))
        attributeString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: (text.lowercased() as NSString).range(of: searchText.lowercased()))
        
        self.attributedText = attributeString
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

extension String {
    var removeHTMLTag: String {
        guard let encodeData = self.data(using: .utf8) else { return self }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue]
        
        do {
            let attributted = try NSAttributedString(data: encodeData, options: options, documentAttributes: nil)
            
            return attributted.string
        } catch { return self }
    }
}
