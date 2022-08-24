//
//  ImageSearchView.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/24/22.
//

import UIKit

class ImageSearchView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
        return view
    }()
    
    override func configureUI() {
        self.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: - CollectionViewLayout
    static func imageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemWidth: CGFloat = deviceWidth / 3
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        return layout
    }
}
