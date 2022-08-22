//
//  ShoppingTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit
import RealmSwift // Realm 1. import RealmSwift

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let localRealm = try! Realm() // Realm 2. Realm테이블에 데이터를 CRUD할 때, Realm파일에 접근하는 상수 선언
    var tasks: Results<UserShoppingList>! // Realm 3. Realm에서 읽어온 데이터를 담을 배열 선언
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.rowHeight = 60
        hideKeyboardWhenTappedBackground()
        
        // Realm 4. 배열에 Realm의 데이터 초기화
        tasks = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "regDate", ascending: false)
        print(tasks)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    func setUI() {
        topBackground.layer.cornerRadius = 7
        topBackground.clipsToBounds = true
        topBackground.backgroundColor = .systemGray6
        
        // textfield
        userTextField.keyboardType = .default
        userTextField.returnKeyType = .join
        userTextField.becomeFirstResponder()
        userTextField.borderStyle = .none
        userTextField.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        userTextField.textAlignment = .left
        userTextField.clearsOnBeginEditing = true
        userTextField.autocorrectionType = .no
        userTextField.autocapitalizationType = .none
        
        // button
        addButton.backgroundColor = .systemGray4
        addButton.layer.cornerRadius = 5
        addButton.clipsToBounds = true
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 7)
    }
    
    // MARK: - [추가] 버튼 클릭시 액션
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        let newList = (userTextField.text == "" ? "오늘 하루 감사하기" : userTextField.text)!
        
        let task = UserShoppingList(shoppingList: newList,
                                    regDate: Date()) // => Record
        
        try! localRealm.write {
            localRealm.add(task) // Create
            
            self.shoppingList.append(newList)
            tableView.reloadData()
            view.endEditing(true)
            
            print("Realm Succeed")
        }
        
        //        shoppingList.append((userTextField.text == "" ? "장바구니 챙기기" : userTextField.text)!)
        //        tableView.reloadData()
        //        view.endEditing(true)
    }
    
    @IBAction func userTextFieldTapped(_ sender: UITextField) {
        shoppingList.append((userTextField.text == "" ? "장바구니 챙기기" : userTextField.text)!)
        tableView.reloadData()
    }
    
    // MARK: - 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
//        return tasks.count
    }
    
    // MARK: - 셀의 UI 및 데이터 등록하기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        // 라벨 데이터 및 설정
        cell.shoppingListLabel.text = shoppingList[indexPath.row]
        cell.shoppingListLabel.font = .systemFont(ofSize: 14)
        
        // 체크박스 이미지
        cell.checkBoxImage.tintColor = .black
        cell.checkBoxImage.image = indexPath.row % 2 == 0 ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "checkmark.square.fill")
        
        // 별표 버튼
        cell.bookMarkButton.tintColor = .black
        indexPath.row % 2 == 0 ? cell.bookMarkButton.setImage(UIImage(systemName: "star"), for: .normal) : cell.bookMarkButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        return cell
    }
    
    // MARK: - 셀 편집 가능하도록 설정
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - 우측 스와이프 디폴트 기능
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //배열삭제 후, 테이블뷰 갱신
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    

}
