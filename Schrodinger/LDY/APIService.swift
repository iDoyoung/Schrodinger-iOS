//
//  APIService.swift
//  Schrodinger
//
//  Created by ido on 2021/08/02.
//

import Foundation

class APIService {
    
    let tomcatUserItemURL = "http://192.168.2.2:8080/schrodinger/schrodinger_mysql_db.jsp"
    let tomcatAllItemURL = "http://192.168.2.2:8080/schrodinger/schrodinger_all_items_mysql_db.jsp"
    
    func performUserItemRequest(completion: @escaping ([Item]) -> Void) {
        
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: tomcatUserItemURL)!
        
        let requestURL = urlComponents.url!
        
        let idQuery = URLQueryItem(name: "id", value: "1")
        
        urlComponents.queryItems?.append(idQuery)
        
        session.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let resultData = data else {
                completion([])
                print("Data is empty")
                return
            }
            let items = APIService.parseItemJSON(resultData)
            completion(items)
        }.resume()
        
    }
    
    func performAllItemRequest(completion: @escaping ([ThrowOutItem]) -> Void) {
        
        let session = URLSession(configuration: .default)
        let requestURL = URL(string: tomcatAllItemURL)!
        
        session.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                print("Error : \(error?.localizedDescription ?? "Can't find error")")
                return
            }
            
            guard let resultData = data else {
                completion([])
                print("Data is empty")
                return
            }
            let items = APIService.parseThrowOutJSON(resultData)
            completion(items)
        }.resume()
    }
    
    static func parseItemJSON(_ data: Data) -> [Item] {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseItems.self, from: data)
            let items = response.items
            return items
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    static func parseThrowOutJSON(_ data: Data) -> [ThrowOutItem] {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseThorwOutItems.self, from: data)
            let items = response.items
            return items
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
}
