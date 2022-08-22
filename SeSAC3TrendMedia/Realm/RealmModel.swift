//
//  RealmModel.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/22/22.
//

import Foundation
import RealmSwift

// UserShoppingList: 테이블 이름
// @Persisted: 컬럼

class UserShoppingList: Object {
    
    @Persisted var doneCheck: Bool //할 일 완료 여부(필수)
    @Persisted var shoppingList: String // 할 일 목록(필수)
    @Persisted var favorite: Bool // 즐겨찾기(필수)
    @Persisted var regDate = Date()  // 등록 날짜(필수)
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(shoppingList: String, regDate: Date) {
        self.init()
        self.doneCheck = false
        self.shoppingList = shoppingList
        self.favorite = false
        self.regDate = regDate
    }
    
    
    
    
}
