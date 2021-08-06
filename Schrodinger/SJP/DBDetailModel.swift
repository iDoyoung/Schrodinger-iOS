//
//  DBDetailModel.swift
//  Schrodinger
//
//  Created by 송정평 on 2021/08/02.
//

import Foundation

class DBDetailModel: NSObject{
    //그냥 써도 상관없으나 타입주는게 좋다! NSObject 가 가장 큼
    
    var pname: String?
    var throwDate: String?
    var item: String?
    var update: String?
    var memo: String?
    var submitDate: String?
    var expirationDate: String?
    var image: String?
    var useCompletionDate: String?
    
    
    //Empty constructor 잊지말고 써야한다 / 오류날때가 있음
    override init() {
        
    }
    
   
    
    init(pname: String, item: String, memo: String , expirationDate: String, image: String) {
        self.item = item
        self.pname = pname
        self.memo = memo
        self.expirationDate = expirationDate
        self.image = image
    }
    
    init(throwDate: String) {
     self.throwDate = throwDate
 
 }
    
    init(submitDate: String) {
     self.submitDate = submitDate
 
 }
    
    init(throwDate: String,useCompletionDate: String) {
     self.throwDate = throwDate
    self.useCompletionDate = useCompletionDate
 
 }
    
}//class

