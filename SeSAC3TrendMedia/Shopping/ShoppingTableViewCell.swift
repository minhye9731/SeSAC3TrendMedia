//
//  ShoppingTableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit
import UnsplashPhotoPicker

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var checkBoxButtonTapped : (() -> Void) = {}
    var bookMarkButtonTapped : (() -> Void) = {}
    
    // unsplash photo 표기 설정
    private var imageDataTask: URLSessionDataTask?
    static var cache: URLCache = {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let diskPath = "unsplash"
        
        if #available(iOS 13.0, *) {
            return URLCache(
                memoryCapacity: memoryCapacity,
                diskCapacity: diskCapacity,
                directory: URL(fileURLWithPath: diskPath, isDirectory: true)
            )
        }
        else {
            #if !targetEnvironment(macCatalyst)
            return URLCache(
                memoryCapacity: memoryCapacity,
                diskCapacity: diskCapacity,
                diskPath: diskPath
            )
            #else
            fatalError()
            #endif
        }
    }()
    
    // MARK: - functions
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

// MARK: - unsplash photo 다운로드 함수
extension ShoppingTableViewCell {
    
    func downloadPhoto(_ photo: UnsplashPhoto) {
        guard let url = photo.urls[.regular] else { return }

        if let cachedResponse = ShoppingTableViewCell.cache.cachedResponse(for: URLRequest(url: url)),
            let image = UIImage(data: cachedResponse.data) {
            
            photoImageView.image = image
            return
        }

        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }

            strongSelf.imageDataTask = nil

            guard let data = data, let image = UIImage(data: data), error == nil else { return }

            DispatchQueue.main.async {
                UIView.transition(with: strongSelf.photoImageView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    strongSelf.photoImageView.image = image
                }, completion: nil)
            }
        }

        imageDataTask?.resume()
    }
}
