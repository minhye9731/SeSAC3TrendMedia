//
//  BucketlistTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {
    
    // 클래스는 Reference Type -> 인스턴스 자체를 변경하지 않는 이상 한 번만 될 거다!
    // IBOutlet ViewDidLoad 호출 되기 직전에 nil이 아닌 지 nil인 지 알 수 없음!
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("텍스트필드 DidSet")
        }
    }
    
    // list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신!
    // 딕셔너리로 값을 관리하면 될까?
    var list = [Todo(title: "범죄도시2", done: true), Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData()
            print("list가 변경됨! \(list), \(oldValue)")
        }
    }
    
    static let identifier = "BucketlistTableViewController"
    
    // (1) 값전달 - 플레이스 홀더 문구 가져올 변수
    var textfieldPlaceholder: String?
    // 옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유는?
    // placeholder 자체가 옵셔널이라면?
    // 하지만 String Interpolation이라면?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (3) 값 전달
        userTextField.placeholder = "\(textfieldPlaceholder)를 입력해보세요."
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        tableView.rowHeight = 88
        
        // 딕셔너리는 순서가 없어서 아래처럼 append로 더할 수 없음
//        list.append("마녀")
//        list.append("ㅁㅁㅁ")
    }
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        // case2. if let 구문 활용
//        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) { //. 알아ㅣ보기
//            list.append(value)
//            tableView.reloadData()
//        } else {
//            // n토스트 띄우기
//        }
//
//        // case 3. guard 구문으로 활용
//        // 위와 동일한 구분을 guard 구문으로 바꿔보기
//        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count)
//        else {
//            // 얼럿이나 포스트를 통해서 빈칸을 입력했다, 글자수가 많다 등을 사용자에게 알려줘야 함
//            return
//        }
//        list.append(value)
//        tableView.reloadData()
        
        // case1.
//        list.append(sender.text!)
        // 딕셔너리는 순서가 없어서 아래처럼 append로 더할 수 없음. 그래서 구조체를 만들어서 그 안에 넣음
        list.append(Todo(title: sender.text!, done: false))
//        tableView.reloadData() // 데이터와 화면은 따로 놀기 때문에, 데이터가 달라진다면 뷰에 반영되도록 갱신시켜줘야함
    
        
        
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
        
        cell.bucketlistLabel.text = list[indexPath.row].title
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkboxButton.tag = indexPath.row // 각 버튼에 tag값 쉽게 주는 법
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonClicked(sender:)), for: .touchUpInside)
        
        // 상태에 따른 이미지 적용은 여기에
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    @objc func checkboxButtonClicked(sender: UIButton) {
        print("\(sender)번째 버튼 클릭!")
        
        // 배열 인덱스를 찾아서 done을 바꿔야 된다! 그리고 테이블뷰 갱신 해야 한다!
        // true면 False 주고, false면 true 줘라.
        list[sender.tag].done = !list[sender.tag].done
        
        // 테이블 자체를 갱신하기보다 테이블뷰 셀을 갱신하는게 좋음
//        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        
        // 재사용 셀 오류 확인용 코드
//        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
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
//            tableView.reloadData()
        }
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
}
