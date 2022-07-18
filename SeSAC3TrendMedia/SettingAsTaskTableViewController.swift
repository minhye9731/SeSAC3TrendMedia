//
//  SettingAsTaskTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/18/22.
//

import UIKit

class SettingAsTaskTableViewController: UITableViewController {

    var totalSetting = ["공지사항", "실험실", "버전 정보"]
    var personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var etc = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSeparator()
    }
    
    // MARK: - setSeparator 설정
    func setSeparator() {
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        tableView.separatorColor = .white
    }

    // MARK: - 섹션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // MARK: - header (옵션)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "전체 설정"
        case 1: return "개인 설정"
        case 2: return "기타"
        default:
            return ""
        }
    }
    
    // MARK: - 셀의 갯수(필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return totalSetting.count
        case 1: return personalSetting.count
        case 2: return etc.count
        default: return 0
        }
    }

    // MARK: - 각 셀별 디자인과 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "controlCell")!
        cell.textLabel?.textColor = .lightGray
        cell.textLabel?.font = .boldSystemFont(ofSize: 13)
        
        switch indexPath.section {
        case 0: cell.textLabel?.text = totalSetting[indexPath.row]
        case 1: cell.textLabel?.text = personalSetting[indexPath.row]
        case 2: cell.textLabel?.text = etc[indexPath.row]
        default: cell.textLabel?.text = etc[indexPath.row]
        }
        
        return cell
    }

}
