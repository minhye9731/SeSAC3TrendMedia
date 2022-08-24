//
//  SearchImageViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/24/22.
//

import UIKit
import Kingfisher
import PhotosUI

class SearchImageViewController: BaseViewController {
    
//    var configuration = PHPickerConfiguration() // phpicker
    
    var selectImage: UIImage?
    var selectIndexPath: IndexPath?
//    var objectId
    
    let mainView = ImageSearchView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.BaseColor.background
        
//        configuration.selectionLimit = 1
//        configuration.filter = .any(of: [.images])
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        self.present(picker, animated: true)
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)
        
        // 이거 true로 꼭 설정해라!
        view.isUserInteractionEnabled = true
        mainView.collectionView.isUserInteractionEnabled = true
        
    }

}


// MARK: - collectionview 설정

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDummy.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? Constants.BaseColor.point.cgColor : nil
        
        cell.setImage(data: ImageDummy.data[indexPath.item].url)
        
        return cell
    }
    
    // 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageSearchCollectionViewCell else { return }
        
        selectImage = cell.searchImageView.image
        
        selectIndexPath = indexPath
        
        // 선택한 이미지를 objectid 이용해서 realm에 저장하기
        
        collectionView.reloadData()
        print("이미지 셀이 선택되었다! \(indexPath)")
        dismiss(animated: true)
    }
    
    // 선택해제
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        selectIndexPath = nil
        selectImage = nil
        collectionView.reloadData()
        print("이미지 셀이 해제되었다! \(indexPath)")
    }
}


//extension SearchImageViewController: PHPickerViewControllerDelegate {
//
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//        print("phpicker 에서 \(#function) 선택됨")
//
//        picker.dismiss(animated: true)
//
//    }
//}




