//
//  ListDetailFoodViewController.swift
//  Schrodinger
//
//  Created by MacAir on 2021/08/02.
//

import UIKit

class ListDetailFoodViewController: UIViewController{

    // 그림 연결
    @IBOutlet weak var listTableView: UITableView!
    
    // 데이터 가져올 것 정의
    var feedFoodItem: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Cell의 크기 지정
        listTableView.rowHeight = 95
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool){
        let foodAllModel = FoodAllModel()
        foodAllModel.delegate = self
        foodAllModel.downloadItems()
        
        // MARK: - Table view data source
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    

    
//    // MARK: - MySQL - 정보읽기 (Prepare)
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "sgFood"{
//            let cell = sender as! UITableViewCell    // 변형
//            let indexPath = self.listTableView.indexPath(for: cell)
//
//            let aModel = feedFoodItem[indexPath!.row] as! DBModel
//            let name = aModel.name
//            let expirationDate = aModel.expirationDate
//            let image = aModel.image
//
//            let detailView = segue.destination as! DetailViewController     // DetailViewController에 넘겨 받을 놈 즉, 함수 만들어주기
//            detailView.receiveItems(String(code!), String(name!), String(dept!), String(phone!))
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// itemDownloaded라는 기능을 가지고 있는 extension
extension ListDetailFoodViewController: FoodAllModelProtocol{
    func itemDownloaded(items: NSMutableArray){

        // NSArray를 사용하면 []안에 String, Int 선언 안 해줘도 다 쓸 수 있음
        feedFoodItem = items
        print("-----")
        let temp = feedFoodItem[0] as! DBModel
        
        print(temp.name!)
        print("-----")
        self.listTableView.reloadData()
    
    }
    

}

// MARK: - Table view data source
extension ListDetailFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("==>", feedFoodItem.count)
        return feedFoodItem.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell

        // Configure the cell...
        let item: DBModel = feedFoodItem[indexPath.row] as! DBModel

        // cell. 다음 tableViewCell 이름!
        
        // cell - 이미지
        let imgurl = URL(string: "http://192.168.2.102:8080/schrodinger/images/\(item.image ?? "noImage.png")")
        let data = try? Data(contentsOf: imgurl!)
        cell.imgFood.image = UIImage(data: data!)
        
        // cell - 이름/유통기한
        cell.lblFoodName?.text = "\(item.name!)"
        cell.lblFoodExp?.text = "\(item.expirationDate!)"
        print("---", item.name!)

        return cell
    }

    
}
