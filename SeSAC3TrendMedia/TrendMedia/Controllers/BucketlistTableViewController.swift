//
//  BucketlistTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class BucketlistTableViewController: UITableViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    var list = ["범죄도시2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 88
        
        list.append("마녀")
        list.append("ㅁㅁㅁ")
    }
    
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        list.append(sender.text!)
        print(list)
        
        // 중요!!
        tableView.reloadData() // 섹션과 셀에 대한 데이터를 다시 그려줌.
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], [IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketlistTableViewCell", for: indexPath) as! BucketlistTableViewCell
        cell.bucketlistLabel.text = list[indexPath.row]
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
    }
    
    // 편집이 가능하도록 함
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    } // 얘가 있어샤 commit editing style이 작용ㅇ함
    
    // 우측 스와이프 디폴트 기능: commit edititngStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 배열삭제 후, 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
}
