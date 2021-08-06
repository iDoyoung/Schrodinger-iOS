//
//  MemoViewController.swift
//  Schrodinger
//
//  Created by 송정평 on 2021/08/02.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var btn_back_memo: UINavigationItem!
    @IBOutlet weak var D_tv_Memomain: UITextView!
    

    var preparememo = ""
    var delegate: MemoEdit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Share.memoCount = 1
        D_tv_Memomain.text = "\(preparememo)"
        
    }
    
    @IBAction func M_btn_memoUpdate(_ sender: UIBarButtonItem) {
      
     
        if delegate != nil{
            delegate?.didMessageEditDone(self, message: D_tv_Memomain.text) // viewcontroller의 함수를         }
            navigationController?.popViewController(animated: true) // 화면 보내는 친구
        }
       
        
    }
  
//    //MARK: 메모 클릭시 이벤트
//    @objc func viewMapTapped(sender: UITapGestureRecognizer) {
//
//        if delegate != nil{
//            delegate?.didMessageEditDone(self, message: D_tv_Memomain.text) // viewcontroller의 함수를 실행시켜준다
//
//        }
//        navigationController?.popViewController(animated: true) // 화면 보내는 친구
    }
    
        
      
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



