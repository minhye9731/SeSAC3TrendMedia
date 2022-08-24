//
//  ShoppingListDetailViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/23/22.
//

import UIKit

class ShoppingListDetailViewController: UIViewController {
    
    @IBOutlet weak var detailShoppingListLabel: UILabel!
    @IBOutlet weak var detailDoneImageView: UIImageView!
    @IBOutlet weak var detailFavoriteImageView: UIImageView!
    @IBOutlet weak var productImage: UIImageView!
    
    var detailListLbael = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabel()
        
    }
    
    func configureLabel() {
        detailShoppingListLabel.text = detailListLbael
        detailShoppingListLabel.textColor = .black
        detailShoppingListLabel.textAlignment = .center
        detailShoppingListLabel.font = .boldSystemFont(ofSize: 12)
    }

   
    
}
