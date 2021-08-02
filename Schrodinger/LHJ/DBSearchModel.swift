//
//  DBSearchModel.swift
//  Schrodinger
//
//  Created by 임현진 on 2021/07/30.
//

import Foundation
class DBSearchModel: NSObject {
    
    var pno : Int?
    var name : String?
    var category : String?
    var expirationDate : String?
    var memo : String?
    var image :String?
    var updateDate : String?
    var deleteDate: String?
    var pitems : String?
    
    //Empty constructor
    override init() {
        
    }
    
    init(pno:Int,name:String,category:String,expirationDate:String,memo:String,image:String,updateDate:String,deleteDate:String,pitems:String) {
        
        self.pno = pno
        self.name = name
        self.category = category
        self.expirationDate = expirationDate
        self.memo = memo
        self.image = image
        self.updateDate = updateDate
        self.deleteDate = deleteDate
        self.pitems = pitems
        print(14)
        
    }
    
}