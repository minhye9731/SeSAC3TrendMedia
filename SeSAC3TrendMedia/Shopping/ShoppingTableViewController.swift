//
//  ShoppingTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit
import RealmSwift // Realm 1. import RealmSwift
import UnsplashPhotoPicker

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let repository = UserShoppingRepository()
    
    var delegate: SelectImageDelegate? // detail화면으로 이미지 전달용 delegate
    var selectedImage: UIImage?
    var objectID: ObjectId?

    private var photos = [UnsplashPhoto]() // 사진담을 곳?? 필요하가
    
    var tasks: Results<UserShoppingList>! {
        didSet {
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNav()
        setBarButtonItem()
        
        tableView.rowHeight = 120
        hideKeyboardWhenTappedBackground()
        
        tasks = repository.sort("regDate")
        print("Realm is located at:", localRealm.configuration.fileURL!)

        
//        fetchDocumentZipFile()
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
        addButton.setTitle("검색", for: .normal)
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
                UIAction(title: "쇼핑 리스트 기준으로 정렬하기", image: UIImage(systemName: "line.3.horizontal.decrease.circle"), handler: { _ in
                    self.tasks = self.repository.sort("shoppingList")
                    }),
                UIAction(title: "즐겨찾기 항목 필터링하기", image: UIImage(systemName: "star.fill"), handler: { _ in
                    self.tasks = self.repository.filter("favorite")
                }),
                UIAction(title: "구매완료 항목 필터링하기", image: UIImage(systemName: "checkmark.square"), handler: { _ in
                    self.tasks = self.repository.filter("doneCheck")
                }),
                UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소버튼 클릭")})
            ]
        }
        
        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: menuItems)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "arrow.up.arrow.down"), primaryAction: nil, menu: menu)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(moveToBackup))
        
    }
    
    @objc func moveToBackup() {
        let vc = BackUpViewController()
        transition(vc, transitionStyle: .push)
    }
    
    
    // MARK: - [검색] 버튼 클릭시 액션
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print(#function)
        
        addNewShoppingList() // (1) 쇼핑리스트 추가하고
        presentUnsplashPhotoPicker() // (2) photo 고르러 가고
    }
    
    @IBAction func userTextFieldTapped(_ sender: UITextField) {
        print(#function)
        addNewShoppingList() // (1) 쇼핑리스트 추가하고
        presentUnsplashPhotoPicker() // (2) photo 고르러 가고
    }
    
    // MARK: - (1) 쇼핑리스트 행추가 & realm 데이터 생성
    func addNewShoppingList() {
        let newList = (userTextField.text == "" ? "potato" : userTextField.text)!
        let task = UserShoppingList(shoppingList: newList, regDate: Date())
        
        // Photo 저장 및 구분용 ObjectID 넣어두기
        self.objectID = task.objectId
        
        // (Creat) newList 추가
        repository.addItem(item: task)
        
    }
    
    // MARK: - (2) UNSPLASH picker 열기
    func presentUnsplashPhotoPicker() {
        print("이미지 선택하러 UnsplashPhotoPicker로 화면이동!")
        
        let configuration = UnsplashPhotoPickerConfiguration(
            accessKey: APIKey.UNSPLASH_ACCESSKEY,
            secretKey: APIKey.UNSPLASH_SECRETKEY,
            query: userTextField.text ?? "potato",
            allowsMultipleSelection: false
        )
        
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        
        unsplashPhotoPicker.photoPickerDelegate = self

        present(unsplashPhotoPicker, animated: true, completion: nil)
    }
    
    
    // MARK: - tableView 상세설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        let row = tasks[indexPath.row]
        
        // 체크박스
        let checkImage = row.doneCheck ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkBoxButton.setImage(checkImage, for: .normal)
        
        cell.checkBoxButtonTapped = {
            self.repository.updateDoneCheck(item: row)
        }
        
        // 제품 이미지(UNSPLASH picker 이미지 가져오자)
        // 여기 간략하게 수정해야해
        tasks.forEach {
            if row.objectId == $0.objectId {
                cell.photoImageView.image = loadImageFromDocument(fileName: "\($0.objectId).jpg")
                print("$\($0.objectId)")
            }
        }
        
        // 쇼핑리스트 label
        cell.shoppingListLabel.text = row.shoppingList
        
        // 즐겨찾기 여부
        let starImage = row.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.bookMarkButton.setImage(starImage, for: .normal)
        
        cell.bookMarkButtonTapped = {
            self.repository.updateFavorite(item: row)
        }
        
        return cell
    }
    
    // MARK: - 셀 클릭시 상세화면으로 Realm 데이터 전달
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Shopping", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: "ShoppingListDetailViewController") as! ShoppingListDetailViewController
        
        let row = tasks[indexPath.row]
        let photo = loadImageFromDocument(fileName: "\(row.objectId).jpg")
        print("indexPath.row 클릭!!: \(indexPath.row)")
        print("row 클릭!!: \(row)")
        
//        detailVC.objectIDinCell = row.objectId
        
        // 쇼핑리스트 label 넘기기
        detailVC.detailListLbael = row.shoppingList
        
        // 쇼핑리스트 photo 넘기기
        delegate?.sendImageData(image: photo!)
        
//        detailVC.productImage.image = loadImageFromDocument(fileName: "\(row.objectId).jpg")
        
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - 셀 편집 가능하도록 설정
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - 우측 스와이프 디폴트 기능
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        if editingStyle == .delete {
            
            self.repository.deleteItem(item: row)
            
            // index 순서에 맞게 잘 삭제는 되는데, 마지막 cell 삭제시 run time error 발생이슈 있었음
            tableView.reloadData()
        }
    }
}

// MARK: - UnsplashPhotoPickerDelegate
extension ShoppingTableViewController: UnsplashPhotoPickerDelegate {
    
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        print("Unsplash photo picker did select \(photos.count) photo(s)")
        
        let photo = photos[0]
        guard let url = photo.urls[.regular] else { return }
        print("선택한 포토 url : \(url)")
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data), let objectId = self!.objectID {
                    
                    DispatchQueue.main.async {
                        
                        self?.saveImageToDocument(fileName: "\(objectId).jpg", image: image)
                        print("선택한 이미지 저장. objectId : \(objectId)")
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        
        
//        print("image = \(image), objectId = \(objectId)")
//        if let cachedResponse = ShoppingTableViewCell.cache.cachedResponse(for: URLRequest(url: url)),
//            let image = UIImage(data: cachedResponse.data), let objectId = self.objectID {
//
//            saveImageToDocument(fileName: "\(objectId).jpg", image: image)
//        }
        
        
    }

    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        print("Unsplash photo picker did cancel")
    }
}

// MARK: - url을 이미지로 바꾸기
extension ShoppingTableViewController {
    
    func url2Image(URL: URL?) -> UIImage? {

        do {
            // 이렇게 이미지를 뱉어라
            if URL != nil {
                let data = try Data(contentsOf: URL!)
                return UIImage(data: data)
            }
        // 아니면 에러나고
        } catch (let error) {
            print("error발생 : \(error)")
        }

        return nil
    }

}

// MARK: - 기타 함수들
extension ShoppingTableViewController {
    
    
    
    
}
