//
//  CalendarViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/30.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    var items = [CalendarItem]()
    var chooseDateItems = [CalendarItem]()
    
    func chooseDate(date: String) {
        chooseDateItems = items.filter{ $0.date == date}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService().performCalendarRequest { items in
            DispatchQueue.main.async {
                self.items = items
                self.chooseDate(date: Date().toString())
                self.calendarView.reloadData()
                self.tableView.reloadData()
            }
        }
        calendarView.delegate = self
        calendarView.dataSource = self
        tableView.dataSource = self
    }

}

extension CalendarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chooseDateItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfCalendar") as? CellOfCalendar else {
            return UITableViewCell()
        }
        cell.itemName.text = chooseDateItems[indexPath.row].name
        
        guard chooseDateItems[indexPath.row].throwOut != "null" else {
            
            guard chooseDateItems[indexPath.row].used != "null" else {
                cell.itemStatus.text = ""
                return cell
            }
            cell.itemStatus.text = "Used all"
            cell.itemStatus.textColor = .systemGreen
            return cell
        }
        cell.itemStatus.text = "Threw away"
        cell.itemStatus.textColor = .systemPink
        return cell
    }
}

extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        chooseDate(date: date.toString())
        tableView.reloadData()
    }
    
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let expiredDate: [Date] = self.items.map{ $0.date.toDate()}
        if expiredDate.contains(date) {
            return 1
        } else {
            return 0
        }
    }
}
class CellOfCalendar: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemStatus: UILabel!
    
}
