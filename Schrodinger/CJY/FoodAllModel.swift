//
//  FoodAllModel.swift
//  Schrodinger
//
//  Created by Jiyeon on 2021/08/03.
//

import Foundation

// MARK: protocol FoodAllModelProtocol
protocol FoodAllModelProtocol{
    
    func itemDownloaded(items: NSMutableArray) // 배열 만드는 것 NSArray(NS = Next Step)
    
}


// MARK: FoodAllModel class
class FoodAllModel{
    var delegate: FoodAllModelProtocol!
    let urlPath = "http://192.168.2.102:8080/schrodinger/food_all_schrodinger.jsp"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is download")
                self.parseJSON(data!) // 데이터 받아서 파싱해주는 것
            }
            
        }
        task.resume()
    }
    
    // 파싱 만들기
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray() // ArrayList..
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let name = jsonElement["name"] as? String, // if let은 여러 개 쓸 수 있다.
               let expirationDate = jsonElement["expirationDate"] as? String,
               let image = jsonElement["image"] as? String{
                let query = DBModel(name: name, expirationDate: expirationDate, image: image)
                locations.add(query)
                print(name, expirationDate, image)
            }
        }
        // async 방식은 Dispatch가 사용된다.
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        }) // Void 함수
        
    }
}

// 이 메소드는 TableViewController에서 쓸 것임... 저기에 쓰기 싫어서 여기다가 쓰는 것

