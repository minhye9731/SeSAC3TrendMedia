//
//  SearchTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class SearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 114
    }
    
    // MARK: - 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    // MARK: - 셀의 UI 및 데이터 등록하기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        // 영화 포스터 이미지
        cell.posterImageView.image = UIImage(named: "해리포터와불의잔.png")
        
        // 영화제목 라벨 데이터
        cell.movieTitleLabel.text = "해리 포터와 불의 잔(Harry Potter and the Goblet of Fire)"
        
        // 영화 출시일 데이터
        cell.movieReleasedDateLabel.text = "2005. 11. 16 | EN"
        
        // 영화 시놉시스 데이터
        cell.movieSynopsisLabel.text = "요즘 들어 매일 꾸는 악몽 때문에 이마의 상처에 더욱 통증을 느끼는 해리는 친구 론과 헤르미온느와 함께 쿼디치 월드컵에 참가해 악몽에서 벗어날 수 있게 돼 마냥 기쁘다. 그러나 퀴디치 캠프장 근방 하늘에 불길한 기운이 나타난다. 바로 마왕 볼드모트의 상징인 '어둠의 표식'이 나타난 것."
        
        return cell
    }


}
