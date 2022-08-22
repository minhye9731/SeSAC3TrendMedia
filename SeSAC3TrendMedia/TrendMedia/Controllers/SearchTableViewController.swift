//
//  SearchTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var movieList = MovieInfo()
    // movieinfo 데이터 안에 기본값이 있어서 매개변수가 안나옴
    
    // MARK: - 뷰컨트롤러 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 114
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonClicked))
        
    }
 
    
    // MARK: - 일반 액션
    /// 초기화되면서 첫화면으로 이동해주는 코드
    @objc
    func resetButtonClicked() {
        //iOS13+ SceneDelegate 쓸 때 동작하는 코드
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // 씬들이 연결되어 있는 것 중에 하나를 데리고 와라.
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        // SceneDelegate로 접근함
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
    
    // MARK: - 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    // MARK: - 셀의 UI 및 데이터 등록하기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        
        // 영화 포스터 이미지
        cell.posterImageView.image = UIImage(named: "해리포터와불의잔.png")
        
        let data = movieList.movie[indexPath.row]
        // 우리가 가져올 프로퍼티를 가져오기 위해 movieList.movie를 해준다
        // 이부분이 항상 헷갈려서 어려웠다.
        cell.setCellUI(data: data)

 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt") // 동작하지 않는다면? 1. TableView가 noSelection 2. 셀 위에 전체 버튼
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RecommendCollectionViewController") as! RecommendCollectionViewController
        
        // 2. 값 전달 - vc가 가지고 있는 프로퍼티에 데이터 추가
//        let title = movieList.movie[indexPath.row].title
//        let release = movieList.movie[indexPath.row].releaseDate
//        vc.movieTitle = "\(title)(\(release))"
        vc.movieData = movieList.movie[indexPath.row]
        
        
        // navigationcontroller 붙어있는지 확인해서 붙어있으면 push해라.
        // navigationcontroller없으면 그냥 cell 아무일도 안일어난다
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
