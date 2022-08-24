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
    
    let localRealm = try! Realm()
    
    var selectedImage: UIImage?
    var objectID: ObjectId?
    
    // unsplash photo 표기 설정
//    var imageDataTask: URLSessionDataTask?
//    var cache: URLCache = {
//        let memoryCapacity = 50 * 1024 * 1024
//        let diskCapacity = 100 * 1024 * 1024
//        let diskPath = "unsplash"
//
//        if #available(iOS 13.0, *) {
//            return URLCache(
//                memoryCapacity: memoryCapacity,
//                diskCapacity: diskCapacity,
//                directory: URL(fileURLWithPath: diskPath, isDirectory: true)
//            )
//        }
//        else {
//            #if !targetEnvironment(macCatalyst)
//            return URLCache(
//                memoryCapacity: memoryCapacity,
//                diskCapacity: diskCapacity,
//                diskPath: diskPath
//            )
//            #else
//            fatalError()
//            #endif
//        }
//    }()
//
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
                    self.tasks = self.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "shoppingList", ascending: true)
                    }),
                UIAction(title: "즐겨찾기 항목 필터링하기", image: UIImage(systemName: "star.fill"), handler: { _ in
                    self.tasks = self.localRealm.objects(UserShoppingList.self).filter("favorite == true")
                }),
                UIAction(title: "구매완료 항목 필터링하기", image: UIImage(systemName: "checkmark.square"), handler: { _ in
                    self.tasks = self.localRealm.objects(UserShoppingList.self).filter("doneCheck == true")
                }),
                UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소버튼 클릭")})
            ]
        }
        
        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: menuItems)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "arrow.up.arrow.down"), primaryAction: nil, menu: menu)
        
    }
    
    // MARK: - [검색] 버튼 클릭시 액션
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print(#function)
        
//        let vc = BackUpViewController()
//        transition(vc, transitionStyle: .present)
        
        addNewShoppingList()
        presentUnsplashPhotoPicker()
    }
    
    @IBAction func userTextFieldTapped(_ sender: UITextField) {
        print(#function)
        addNewShoppingList()
        presentUnsplashPhotoPicker()
    }
    
    // (1) 쇼핑리스트 행추가 & realm 데이터 생성
    func addNewShoppingList() {
        let newList = (userTextField.text == "" ? "감자" : userTextField.text)!
        let task = UserShoppingList(shoppingList: newList, regDate: Date()) // => Record
        
        // Photo 저장 및 구분용 ObjectID 넣어두기
        self.objectID = task.objectId
        
        // (Creat) 데이터상 newList 생성
        try! localRealm.write {
            localRealm.add(task)
            print("신규 리스트 생성! \(newList)")
            tableView.reloadData()
            view.endEditing(true)
        }
        
        // 이미지 픽업 화면으로 이동 -> UNSPLASH picker 로 대체함
//        let vc = SearchImageViewController()
//        print("이미지 선택하러 화면이동!")
//        self.present(vc, animated: true)
    }
    
    // (2) UNSPLASH picker 열기
    func presentUnsplashPhotoPicker() {
        print("이미지 선택하러 UnsplashPhotoPicker로 화면이동!")
        
        let configuration = UnsplashPhotoPickerConfiguration(
            accessKey: APIKey.UNSPLASH_ACCESSKEY,
            secretKey: APIKey.UNSPLASH_SECRETKEY,
            query: userTextField.text ?? "감자",
            allowsMultipleSelection: false
        )
        
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = self

        present(unsplashPhotoPicker, animated: true, completion: nil)
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
        
        // 제품 이미지(UNSPLASH picker 이미지 가져오자)
        tasks.forEach {
            if row == $0.objectId {
                cell.photoImageView.image = loadImageFromDocument(fileName: "\($0.objectId).jpg")
            }
        }
        
        
//        cell.photoImageView.image = UIImage(systemName: "xmark")
        
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
    
    // MARK: - 셀 클릭시 상세화면으로 Realm 데이터 전달
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Shopping", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: "ShoppingListDetailViewController") as! ShoppingListDetailViewController
        
        let row = tasks[indexPath.row]
        
        detailVC.detailListLbael = row.shoppingList
        detailVC.productImage.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        self.navigationController?.pushViewController(detailVC, animated: true)
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
            removeImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
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
                        self?.tableView.reloadData()
                        print("save 이미지 reload 완료")
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

