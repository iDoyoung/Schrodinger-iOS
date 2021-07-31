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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonUI(allButton)
        allButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        foodButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        cosmeticsButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        medicineButton.addTarget(self, action: #selector(showList(_:)), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self
       
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
    
}

extension WorldViewController: UITableViewDelegate {
    
}

extension WorldViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfWorld") as? CellOfWorldRanking else {
            return UITableViewCell()
        }
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        return cell
    }
    
}

class CellOfWorldRanking: UITableViewCell {
    
}
