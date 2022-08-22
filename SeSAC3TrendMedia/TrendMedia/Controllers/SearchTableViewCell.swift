//
//  SearchTableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieReleasedDateLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    // 추가 Test
    @IBOutlet weak var sampleButton : UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setCellUI(data: Movie) {
        
//        sampleButton.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
        
//        sampleButton.titleLabel?.text
//        sampleButton.currentImage // get전용
        
//        sampleButton.currentTitle = "ㅁㅁ" // 여기 에러나는 이유는, get 전용이기 떄문
        
        
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 11)
        movieTitleLabel.textColor = .label
        movieTitleLabel.text = data.title
        
        movieReleasedDateLabel.font = UIFont.systemFont(ofSize: 11)
        movieReleasedDateLabel.textColor = .lightGray
//        movieReleasedDateLabel.text = "\(data.rate) | \(data.runtime)분 | \(data.rate)점"
        movieReleasedDateLabel.text = data.movieDescriptoin
        
        movieSynopsisLabel.font = UIFont.systemFont(ofSize: 11)
        movieSynopsisLabel.textColor = .lightGray
        movieSynopsisLabel.text = data.overview
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
