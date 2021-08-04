//
//  SearchViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/29.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("feedItem.count =" , feedItem.count)
        return feedItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! SearchTableViewCell
        let item:DBSearchModel = feedItem[indexPath.row] as! DBSearchModel
        print(4)
        let url = URL(string: "http://192.168.2.101:8080/schrodinger/images/\(item.image!)")
        print("http://192.168.2.101:8080/schrodinger/images/\(item.image!)")
        let data = try? Data(contentsOf: url!)
        cell.ImgView.image = (UIImage(data: data!))
        
        print("사진 : \(item.image!)")
        
        cell.NameTitle?.text = "물품명 : \(item.name!)"
        cell.Date?.text = "유통기간 : \(item.expirationDate!)"
        print("유통기간 : \(item.expirationDate!)")
        print(5)
        return cell
    }
    

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    var feedItem:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.rowHeight = 60
        print(1)
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func SegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let queryModel = SubmitQueryModel()
            queryModel.delegate = self
            queryModel.downloadItem(name: SearchBar.text!)
            print(2)
        }else if sender.selectedSegmentIndex == 1 {
            let queryModel = UseQueryModel()
            queryModel.delegate = self
            queryModel.downloadItemed(name: SearchBar.text!)
            print(2)
        }else if sender.selectedSegmentIndex == 2 {
            let queryModel = SearchQueryModel()
            queryModel.delegate = self
            queryModel.downloadItems(name: SearchBar.text!)
            print(2)
        }
    }
    
    /*
    // MARK: - Navigation
     //지금 합쳐지지 않아서 막아놓음 --> 테이블 셀 중 하나를 누르면 디테일 뷰로 해당 셀의 정보를 부르게 하기!!!!
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
     let cell = sender as! UITableViewCell
     let indexPath = self.listTableView.indexPath(for: cell)
     let detailView = segue.destination as! DetailViewController
     
     let item:DBSearchModel = feedItem[indexPath!.row] as! DBSearchModel
     
     detailView.receivePno(pno: item.pno!)
     print(8)
     }
    }
    */
  
}
extension SearchViewController:UseQueryModelProtocol{
    func itemDownloaded(items: NSArray) {
        feedItem = items as! NSMutableArray
        self.listTableView.reloadData()
        print(3)
    }
}

extension SearchViewController:SearchQueryModelProtocol{
    func itemDownload(items: NSArray) {
        feedItem = items
        self.listTableView.reloadData()
        print(3)
    }
}

extension SearchViewController:SubmitQueryModelProtocol{
    func itemDownloads(items: NSArray) {
        feedItem = items as! NSMutableArray
        self.listTableView.reloadData()
        print(3)
    }
}



