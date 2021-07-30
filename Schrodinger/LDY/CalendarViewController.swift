//
//  CalendarViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/30.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension CalendarViewController: UITableViewDataSource {
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

class CellOfCalendar: UITableViewCell {
    
}
