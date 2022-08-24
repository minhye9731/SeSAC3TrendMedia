//
//  BackUpTableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/25/22.
//

import UIKit

class BackUpTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
       let view = UILabel()
        view.text = "test"
        view.textColor = Constants.BaseColor.text
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    override func configure() {
        backgroundColor = .darkGray
        contentView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(100)
        }
    }
    

}
