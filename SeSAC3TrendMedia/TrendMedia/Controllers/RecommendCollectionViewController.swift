//
//  RecommendCollectionViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/20/22.
//

import UIKit
import Toast
import Kingfisher

/*
 TableView -> CollectionView
 Row -> Item
 heightForRowAt -> ??? FLowLayout (heightForRowAt이 없는 이유)
 */

class RecommendCollectionViewController: UICollectionViewController {
    
    // 1. 값 전달 - 데이터를 받을 공간(프로퍼티) 생성
    var movieData: Movie?
    // 따로 따로 프로퍼티 생성하지 않고 하나의 구조체 전체를 전달 받는 이유는? - 활용도, 깔끔함 등
    
    
    var image = "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20220620_61%2F1655692158584QeRHN_JPEG%2Fmovie_image.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. 값 전달 - 프로퍼티 값을 뷰에 표현
//        title = movieTitle == nil ? "데이터 없음" : movieTitle!
        title = movieData?.title
        

        // 화면에 뜨기전에 크기 정해줘야 함
        // 컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정 (estimate size는 none으로 설정)
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8 // 기본값은 int로 설정되지만 하단에 타요소에도 편하게 적용하기 위해 타입을 어노테이션 해줌
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing // 보통 이 두개는 같은수치로 적용함
        layout.minimumInteritemSpacing = spacing // 보통 이 두개는 같은수치로 적용함
        collectionView.collectionViewLayout = layout
   
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         // guard let, 옵셔널 바인딩 샘픞
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell else {
            return RecommendCollectionViewCell()
        }
        cell.posterImageView.backgroundColor = .orange
        
        let url = URL(string: image)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 2, position: .center)
        // 키보드가 있을때는 가려지기 떄문에, 위치를 center로 옮겨줌
        
        // pop
        self.navigationController?.popViewController(animated: true)
    }

}
