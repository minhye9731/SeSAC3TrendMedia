//
//  ShoppingTableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    var checkBoxButtonTapped : (() -> Void) = {}
    var bookMarkButtonTapped : (() -> Void) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureButton()
        configureLabel()
    }
    
    func configureCell() {
        cellBackground.layer.cornerRadius = 7
        cellBackground.clipsToBounds = true
        cellBackground.backgroundColor = .systemGray6
    }
    
    func configureButton() {
        checkBoxButton.setTitle("", for: .normal)
        checkBoxButton.tintColor = .black
        checkBoxButton.addTarget(self, action: #selector(checkBoxButtonToggle), for: .touchUpInside)

        bookMarkButton.tintColor = .black
        bookMarkButton.addTarget(self, action: #selector(bookMarkButtonToggle), for: .touchUpInside)
    }
    
    func configureLabel() {
        shoppingListLabel.font = .systemFont(ofSize: 14)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func checkBoxButtonToggle() {
        checkBoxButtonTapped()
    }
    
    @objc func bookMarkButtonToggle() {
        bookMarkButtonTapped()
    }

}
