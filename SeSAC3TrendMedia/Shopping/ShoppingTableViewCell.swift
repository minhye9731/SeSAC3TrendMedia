//
//  ShoppingTableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 7
        cellBackground.clipsToBounds = true
        cellBackground.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
