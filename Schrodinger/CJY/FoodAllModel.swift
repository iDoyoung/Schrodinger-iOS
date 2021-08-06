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
    var urlPath = share.url("food_all_schrodinger.jsp")
    
    func downloadItems(check: String) {
        urlPath = urlPath + "&check=\(check)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            //if error != nil{
                //print("Failed to download data")
            //}else{
                print("Data is download")
            self.parseJSON(data) // 데이터 받아서 파싱해주는 것
            //}
            
        }
        task.resume()
    }
    
    
    // 파싱 만들기
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        }catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray() // ArrayList..
        print(jsonResult.count)
        if jsonResult.count != 0 {
            for i in 0..<jsonResult.count{
                jsonElement = jsonResult[i] as! NSDictionary
                if let pno = jsonElement["pno"] as? String, // JSON은 무조건 String, 따라서, jsp에서 Int가 "" 감싸져 있다면 int라도 String으로
                   let name = jsonElement["name"] as? String,
                   let expirationDate = jsonElement["expirationDate"] as? String,
                   let image = jsonElement["image"] as? String{
                    let query = DBModel(pno: Int(pno)!, name: name, expirationDate: expirationDate, image: image)
                    locations.add(query)
                    print(pno, name, expirationDate, image)
                }
            }
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.itemDownloaded(items: locations)
            })
        }       
//        // async 방식은 Dispatch가 사용된다.
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.delegate.itemDownloaded(items: locations)
//        }) // Void 함수
        
    }
}


