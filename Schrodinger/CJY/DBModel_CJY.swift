//
//  DBModel_CJY.swift
//  Schrodinger
//
//  Created by Jiyeon on 2021/08/03.
//

import Foundation

class DBModel: NSObject{
    var name: String?
    var expirationDate: String?
    var image: String?
    
    // 서버에 올리므로 이미지도 string? UIImage가 아니라?
    
    // MARK: Empty constructor
    override init() {
        
    }
    
    // 생성자 만듦
    init(name: String, expirationDate: String, image: String) {
        self.name = name
        self.expirationDate = expirationDate
        self.image = image
    }
}
