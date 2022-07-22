//
//  TrendTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/21/22.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func movieButtonTapped(_ sender: UIButton) {
        // 화면전환: 1. 스토리보드 파일 찾고 2. 스토리보드내 뷰컨트롤러 찾고 3. 화면전환
        // 영화버튼 클릭 > BucketlistTableViewController Present
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // (bundle은 라이브러리나 다른곳에서 스토리보드를 가져올때 사용)
        
        //2.
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        // (2) 값전달
        vc.textfieldPlaceholder = "영화"
        
        //3.
        self.present(vc, animated: true)
    }
    
    
    @IBAction func dramaButtonTapped(_ sender: UIButton) {
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // (bundle은 라이브러리나 다른곳에서 스토리보드를 가져올때 사용)
        
        //2.
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        //2.5 present 시 화면 전환 방식 설정 (옵션)
        vc.modalPresentationStyle = .fullScreen
        
        // (2) 값전달
        vc.userTextField.placeholder = sender.currentTitle
        
        
        //3.
        self.present(vc, animated: true)
    }
    
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // (bundle은 라이브러리나 다른곳에서 스토리보드를 가져올때 사용)
        
        //2.
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        // (2) 값전달
        vc.textfieldPlaceholder = "도서"
        
        
        // 2.5 코드로 네비게이션 컨트롤러 임베드하기
        let nav = UINavigationController(rootViewController: vc)
        
        //2.5 present 시 화면 전환 방식 설정 (옵션)
        // present를 한 주체가 vc가 아닌 nav라서, 시뮬에는 fullscreen 적용이 안됨
        // 여기서 vc대신 nav로 써주면 fullscreen이 됨
        nav.modalPresentationStyle = .fullScreen
        
        //3.
        self.present(nav, animated: true)
    }
    
    
    
    
    
    
}


