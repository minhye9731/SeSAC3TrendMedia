//
//  ImageSearchCollectionViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/24/22.
//

import UIKit
import Kingfisher

class ImageSearchCollectionViewCell: BaseCollectionViewCell {
    
    let searchImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = Constants.BaseColor.background
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        // contentview 추가함
        self.contentView.addSubview(searchImageView)
    }
    
    override func setConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func setImage(data: String) {
        let url = URL(string: data)
        searchImageView.kf.setImage(with: url)
    }
}
