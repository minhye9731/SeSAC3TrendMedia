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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNav()
        setBarButtonItem()
        
        tableView.rowHeight = 60
        hideKeyboardWhenTappedBackground()
        
        // Realm 4. 배열에 Realm의 데이터 초기화
        tasks = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "regDate", ascending: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    // 이거 별도 view로 빼서 깔끔하게 정리하자!
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
    
    func setNav() {
        self.navigationItem.title = "Shopping List"
        self.navigationController?.navigationBar.tintColor = .black
        
        let navibarAppearance = UINavigationBarAppearance()
        let barbuttonItemAppearance = UIBarButtonItemAppearance()
        
        navibarAppearance.backgroundColor = .clear
        navibarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        barbuttonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black, .backgroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        
        self.navigationItem.scrollEdgeAppearance = navibarAppearance
        self.navigationItem.standardAppearance = navibarAppearance
        navibarAppearance.buttonAppearance = barbuttonItemAppearance
    }
    
    
    func setBarButtonItem() {
        
        // UIMenu 요소들
        var menuItems: [UIAction] {
            return [
                UIAction(title: "할 일 기준으로 정렬하기", image: UIImage(systemName: "star.fill"), handler: { _ in print("1")}),
                UIAction(title: "즐겨찾기 기준으로 정렬하기", image: UIImage(systemName: "star.fill"), handler: { _ in print("2")}),
                UIAction(title: "구매완료 기준으로 정렬하기", image: UIImage(systemName: "star.fill"), handler: { _ in print("3")}),
                UIAction(title: "제목순으로 정렬하기", image: UIImage(systemName: "star.fill"), handler: { _ in print("4")}),
                UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소버튼 클릭")})
            ]
        }
        
        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: menuItems)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "arrow.up.arrow.down"), primaryAction: nil, menu: menu)
        
    }
    
    // MARK: - [추가] 버튼 클릭시 액션
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addNewShoppingList()
    }
    
    @IBAction func userTextFieldTapped(_ sender: UITextField) {
        addNewShoppingList()
    }
    
    func addNewShoppingList() {
        let newList = (userTextField.text == "" ? "오늘 하루 감사하기" : userTextField.text)!
        let task = UserShoppingList(shoppingList: newList, regDate: Date()) // => Record
        
        try! localRealm.write {
            localRealm.add(task) // (Creat) 데이터상 newList 생성
            tableView.reloadData()
            view.endEditing(true)
        }
    }
    
    
    // MARK: - 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // MARK: - 셀의 UI 및 데이터 등록하기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        let row = tasks[indexPath.row]
        
        // 체크박스
        let checkImage = row.doneCheck ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkBoxButton.setImage(checkImage, for: .normal)
        
        cell.checkBoxButtonTapped = {
            try! self.localRealm.write {
                row.doneCheck = !row.doneCheck
                tableView.reloadData()
            }
        }
        
        // 라벨 데이터 및 설정
        cell.shoppingListLabel.text = row.shoppingList
        
        // 즐겨찾기 여부
        let starImage = row.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.bookMarkButton.setImage(starImage, for: .normal)
        
        cell.bookMarkButtonTapped = {
            try! self.localRealm.write {
                row.favorite = !row.favorite
                tableView.reloadData()
            }
        }
        
        return cell
    }
    
    // MARK: - 셀 편집 가능하도록 설정
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - 우측 스와이프 디폴트 기능
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
                print("삭제됨 : \(tasks[indexPath.row])")
            }
            
            tableView.reloadData()
        }
    }
    

}
