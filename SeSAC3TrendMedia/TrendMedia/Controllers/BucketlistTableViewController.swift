//
//  BucketlistTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

class BucketlistTableViewController: UITableViewController {

    static let identifier = "BucketlistTableViewController"
    
    @IBOutlet weak var userTextField: UITextField!
    
    var list = ["범죄도시2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        tableView.rowHeight = 88
        
        list.append("마녀")
        list.append("ㅁㅁㅁ")
    }
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        // case1.
//        list.append(sender.text!)
//        print(list)
        
        // case2. if let 구문 활용
        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) { //. 알아ㅣ보기
            list.append(value)
            tableView.reloadData()
        } else {
            // n토스트 띄우기
        }
        
        // case 3. guard 구문으로 활용
        // 위와 동일한 구분을 guard 구문으로 바꿔보기
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count)
        else {
            // 얼럿이나 포스트를 통해서 빈칸을 입력했다, 글자수가 많다 등을 사용자에게 알려줘야 함
            return
        }
        list.append(value)
        tableView.reloadData()
        
        
    
        
        
        // 중요!!
        tableView.reloadData() // 섹션과 셀에 대한 데이터를 다시 그려줌.
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], [IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifier, for: indexPath) as! BucketlistTableViewCell
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
