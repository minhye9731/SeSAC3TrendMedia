//
//  ShoppingListDetailViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/23/22.
//

import UIKit
import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class ShoppingListDetailViewController: UIViewController {
    
    @IBOutlet weak var detailShoppingListLabel: UILabel!
    @IBOutlet weak var detailDoneImageView: UIImageView!
    @IBOutlet weak var detailFavoriteImageView: UIImageView!
    @IBOutlet weak var productImage: UIImageView!
    
    var detailListLbael = "test"
//    var objectIDinCell: ObjectId?

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

    func configurePhoto() {
//        productImage.image = loadImageFromDocument(fileName: "\(objectIDinCell).jpg")
        productImage.contentMode = .scaleAspectFill
    }
   
    
}


extension ShoppingListDetailViewController: SelectImageDelegate {
    
    // 이 함수의 실행은 메인페이지에서 셀을 didselect할 때 호출되면 되겠다!
    func sendImageData(image: UIImage) {
        productImage.image = image
        print(#function)
    }
}
