//
//  ItemModel.swift
//  Schrodinger
//
//  Created by ido on 2021/08/02.
//

import Foundation

struct Item: Codable {
    
    let id: String
    let name: String
    let kind: String
    let date: String
    let image: String?
    //let delete: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "pno"
        case name = "name"
        case kind = "category"
        case date = "expirationDate"
        case image = "image"
        //case delete = "deleteDate"
        
    }
}

struct UseRatio: Codable {
    
    let throwOutCount: Int
    let useCount: Int
    
    enum CodingKeys: String, CodingKey {
        case throwOutCount = "??"
        case useCount = "???"
    }
}

struct ThrowOutItem: Codable {
    
    let totalOfThrowOut: String
    let name: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case totalOfThrowOut = "tcount"
        case name = "name"
        case category = "category"
    }
}


struct ResponseThorwOutItems: Codable {
    let items: [ThrowOutItem]
}

struct ResponseItems: Codable {
    let items: [Item]
}
