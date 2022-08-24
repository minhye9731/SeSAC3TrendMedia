//
//  BackUpView.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/25/22.
//

import UIKit

class BackUpView: BaseView {

    let backUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("백업", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("복구", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .top
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        return stackview
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 50
        return tableView
    }()
    
    override func configureUI() {
        backgroundColor = Constants.BaseColor.background
        
        [stackView, tableView].forEach {
            self.addSubview($0)
        }
        
        [backUpButton, restoreButton].forEach {
            stackView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(70)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(70)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
}
