//
//  UITextField+Extension.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

extension UITextField {

    // 선언이 불가능한 ㄴ자ㅖ흫 ㄷ;래ㅗ아으 ㄹㅇ라이니
    func borderColor() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
        
    }
    
    
}
