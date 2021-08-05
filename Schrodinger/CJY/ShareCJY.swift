//
//  ShareCJY.swift
//  Schrodinger
//
//  Created by Jiyeon on 2021/08/03.
//

import Foundation

struct ShareCJY {
    
    func url(_ fileName: String) -> String{
        let url = "http://172.30.1.19:8080/schrodinger/\(fileName)?id=1"
        return url
    }
    
    func imgUrl(_ fileName: String) -> String{
        let url = "http://172.30.1.19:8080/schrodinger/images/\(fileName)?id=1"
        return url
    }
}