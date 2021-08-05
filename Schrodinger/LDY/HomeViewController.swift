//
//  HomeViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/29.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var firstSectionTitle: UILabel!
    @IBOutlet weak var todayExpiredItem: UILabel!
    @IBOutlet weak var secondSectionTitle: UILabel!
    @IBOutlet weak var thirdSectionTitle: UILabel!
    @IBOutlet weak var fourthSectionTitle: UILabel!
    @IBOutlet weak var checkTodayButton: UIButton!
    @IBOutlet weak var expiredItemCollectionView: UICollectionView!
    @IBOutlet weak var upcomingExpireCollectionView: UICollectionView!
    @IBOutlet weak var chartView: UIView!
    
    var todayExpired = [String]()
    var expiredItem = [Item]()
    var upcomingExpire = [Item]()
    
    func applyLabel() {
        firstSectionTitle.text = "Today expired item..".localized
        secondSectionTitle.text = "Expired item".localized
        thirdSectionTitle.text = "Upcoming expire".localized
        fourthSectionTitle.text = "My History".localized
    }
    
    func applyButton() {
        checkTodayButton.setTitle("Check".localized, for: .normal)
        checkTodayButton.layer.cornerRadius = 10
        checkTodayButton.addTarget(self, action: #selector(showTodayExpiredList), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLabel()
        applyButton()
        expiredItemCollectionView.delegate = self
        expiredItemCollectionView.dataSource = self
        upcomingExpireCollectionView.delegate = self
        upcomingExpireCollectionView.dataSource = self
        
        chartView.backgroundColor = .secondarySystemBackground
        let pieView = PieChart(frame: CGRect(
                                x: self.chartView.bounds.minX,
                                y: self.chartView.bounds.minY,
                                width: self.view.frame.width - 40,
                                height: self.view.frame.width - 40))
        pieView.backgroundColor = .systemBackground
        chartView.addSubview(pieView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        APIService().performUserItemRequest { items in
            DispatchQueue.global().async {
                self.todayExpired = items.filter{ $0.date == Date().toString() }.map { $0.name }
                self.upcomingExpire = items.filter{ Date() >= $0.date.toDate().beforeOneWeek() && $0.date.toDate() > Date()}
                self.expiredItem = items.filter{ $0.date.toDate() <= Date() }
                DispatchQueue.main.sync {
                    self.expiredItemCollectionView.reloadData()
                    self.upcomingExpireCollectionView.reloadData()
                    self.todayExpiredItem.text = self.todayExpired.joined(separator: " ")
                }
            }
        }
        
        //MARK: Todo redraw pie chart
    }
    @objc func showTodayExpiredList() {
        //TODO: Apply push today expired list
        
        //Testing Method
        let storyboard = UIStoryboard(name: "DyLee", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WorldViewController")
        present(destinationVC, animated: true, completion: nil)
    }
   
}

//MARK: MOVE TO DETAIL
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == expiredItemCollectionView {
            print("item is \(self.expiredItem[indexPath.item].name)")
        } else {
            print(self.upcomingExpire[indexPath.item].name)
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case expiredItemCollectionView:
            print("Expired Item : \(expiredItem.count)")
            return expiredItem.count
        case upcomingExpireCollectionView:
            print("Upcoming Item : \(upcomingExpire.count)")
            return upcomingExpire.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellOfHomeView", for: indexPath) as? CellOfHomeView else {
            return UICollectionViewCell()
        }
        switch collectionView {
        case expiredItemCollectionView:
            DispatchQueue.global().async {
                guard let url = URL(string: "\(APIService().imageURL)\(self.expiredItem[indexPath.item].image!)") else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.cellImageView.image = image
                }
            }
        case upcomingExpireCollectionView:
            DispatchQueue.global().async {
                guard let url: URL = URL(string: "\(APIService().imageURL)\(self.upcomingExpire[indexPath.item].image!)") else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.cellImageView.image = image
                }
            }
        default:
            print("empty")
        }
        return cell
    }
    
}

class CellOfHomeView: UICollectionViewCell {
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    
}
