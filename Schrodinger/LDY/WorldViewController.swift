//
//  WorldViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/30.
//

import UIKit

class WorldViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var cosmeticsButton: UIButton!
    @IBOutlet weak var medicineButton: UIButton!
    
    var allItems = [ThrowOutItem]()
    var foodAndBeverageItems = [ThrowOutItem]()
    var cosmeticsItems = [ThrowOutItem]()
    var medicineItems = [ThrowOutItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allButton.isSelected = true
        updateButtonUI(allButton)
        allButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        foodButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        cosmeticsButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        medicineButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadAll()
    }
    
    func updateButtonUI(_ button: UIButton) {
        if button.isSelected {
            button.backgroundColor = .systemGreen
            button.setTitleColor(.systemBackground, for: .selected)
        } else {
            button.backgroundColor = .clear
            button.setTitleColor(.systemGreen, for: .normal)
        }
    }
    
    @objc func showList(_ button: UIButton) {
        
        switch button {
        case allButton:
            foodButton.isSelected = false
            cosmeticsButton.isSelected = false
            medicineButton.isSelected = false
            button.isSelected = true
        case foodButton:
            allButton.isSelected = false
            cosmeticsButton.isSelected = false
            medicineButton.isSelected = false
            button.isSelected = true
        case cosmeticsButton:
            allButton.isSelected = false
            foodButton.isSelected = false
            medicineButton.isSelected = false
            button.isSelected = true
        case medicineButton:
            allButton.isSelected = false
            foodButton.isSelected = false
            cosmeticsButton.isSelected = false
            button.isSelected = true
            
        default:
            return
        }
        updateButtonUI(allButton)
        updateButtonUI(foodButton)
        updateButtonUI(cosmeticsButton)
        updateButtonUI(medicineButton)
    }
    
    //MARK: API Service
    func loadAll() {
        APIService().performAllItemRequest { items in
            DispatchQueue.main.async {
                self.allItems = items
                self.tableView.reloadData()
            }
        }
    }
    
//    func loadFoodAndBeverage() {
//
//    }
//
//    func loadCosmetics() {
//
//    }
//
//    func loadMedicine() {
//
//    }

}

extension WorldViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfWorld") as? CellOfWorldRanking else {
            return UITableViewCell()
        }
        cell.itemName.text = allItems[indexPath.row].name
        cell.totalOfThrowOut.text = allItems[indexPath.row].totalOfThrowOut
        return cell
    }
    
}

class CellOfWorldRanking: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var totalOfThrowOut: UILabel!
}
