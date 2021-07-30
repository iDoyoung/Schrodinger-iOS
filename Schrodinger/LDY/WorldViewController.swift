//
//  WorldViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/30.
//

import UIKit

class WorldViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

}

extension WorldViewController: UITableViewDelegate {
    
}

extension WorldViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "") as? CellOfWorldRanking else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
class CellOfWorldRanking: UITableViewCell {
    
}
