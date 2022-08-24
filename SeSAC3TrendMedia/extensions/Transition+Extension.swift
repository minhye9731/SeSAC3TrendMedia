//
//  Transition+Extension.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/24/22.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present // 네비게이션 없이 Present
        case prsentNavigation // 네비게이션 임베드 Present
        case presentFullNavigation // 네비게이션 풀스크린
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
            
        case .prsentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
            
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
            
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
