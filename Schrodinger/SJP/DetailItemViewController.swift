//
//  DetailItemViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/29.
//

import UIKit


// 지연님께 받아야하는 값
var receivepno = 1 // 탭뷰에서 넘어올때 물건 pk
var receiveuid = "" // 탭뷰에서 넘어올때 유저 아이디
var receiveuno = 2// 탭뷰에서 넘어올때 유저 no

var pname = "" // slq에서 상품의 이름 들어가는 곳


class DetailItemViewController: UIViewController {
var MemoSend = ""
var memo = ""
var CurrenteDate = ""   // 현재날짜 넣기
var editimagrFilepath = "" // 이미지 파이주소 넘기기
var Buttoncount = 0 // useall , Throw 버튼
var QueryDetailcount = 0//QuertDetail에서 가져온 값들의 카운트
var QueryTrowcount = 0//QuertThrow에서 가져온 값들의 카운트
var QueryPurchasecount = 0//QuertThrow에서 가져온 값들의 카운트



var QueryDetailItem: NSMutableArray = NSMutableArray()//  //QuertDetail에서 가져온 값들
var QueryThrowItem: NSMutableArray = NSMutableArray()//  //QueryThrow에서 가져온 값들
var DetailPurchaseItem: NSMutableArray = NSMutableArray()//  //QueryPurchase에서 가져온 값들

var RegistrationItem: NSMutableArray = NSMutableArray()  // RegistrationdateModel에서 가져온 값들

var throwlist: Array = Array<Any>() // DetailThrow 디비에서 불러오는 값들을 항목에 넣어준다
var purchaselist: Array = Array<Any>() // DetailPurchase 디비에서 불러오는 값들을 항목에 넣어준다


    
  
     //메모 업데이트 버튼
    @IBOutlet weak var D_lbl_registered: UILabel! // 이미지 하단에 등록일 띄우는 곳
    @IBOutlet weak var D_lbl_image: UILabel!      // 이미지 중앙에 상품 이름 띄운다
    @IBOutlet weak var D_lbl_expirationDate: UILabel!  // 유통기한 날짜 편집에서 띄우는것
    @IBOutlet weak var D_imageview: UIImageView!     // 이미지뷰
    @IBOutlet weak var D_lbl_item: UILabel!         // 현재 보유량
    @IBOutlet weak var D_lbl_throw: UILabel!          // 버린수 띄우기
    @IBOutlet weak var D_lbl_purchase: UILabel!       // 구매수
    @IBOutlet weak var D_tv_memo: UITextView!           // 메모
    @IBOutlet weak var D_btntf_commplete: UIButton!         // 사용완료 및 버리기 버튼
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // 메모 클릭시 이벤트
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewMapTapped))
        D_tv_memo.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    } //viewDidLoad
    
    
    //MARK: 메모 클릭시 이벤트
    @objc func viewMapTapped(sender: UITapGestureRecognizer) {
        
        
//        let memoViewController =  MemoViewController() //인스턴스를 만들어 값을 넘긴다
//        memoViewController.preparememo = memo
//        memoViewController.delegate = self // 함수 실행하고 뒤로 화면을 넘긴다
      
        self.performSegue(withIdentifier: "sgMemo", sender: self)
       
    }
    // 네비게이션 정보 넘겨주기s
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgEdit"{
        
        let editviewcontroller = segue.destination as! EdictViewController
        editviewcontroller.imageFilepath = editimagrFilepath
        editviewcontroller.receivepno = receivepno
            
        }else {
            
            //메모 텍스트 값 넘겨주기
            let Memoviewcontroller = segue.destination as! MemoViewController
            Memoviewcontroller.preparememo = "\(MemoSend)"
            Memoviewcontroller.delegate = self
            
        }
//
//        }else if segue.identifier == "sgMemo" {
//            let memoViewController = segue.destination as! MemoViewController //인스턴스를 만들어 값을 넘긴다
//            memoViewController.preparememo = memo
//            memoViewController.delegate = self // 함수 실행하고 뒤로 화면을 넘긴다
//            self.performSegue(withIdentifier: "sgMemo", sender: self)
//
//        }
    }
    
    // 버린 날짜 및 사용 완료 버튼
    @IBAction func D_btn_commplete(_ sender: UIButton) {
        let testAlert = UIAlertController(title: "please choose", message: "", preferredStyle: .actionSheet)
        // 현재 날짜 검색
        let formatter = DateFormatter(); formatter.dateFormat = "yyyy-MM-dd"
        CurrenteDate = "\(formatter.string(from: Date()))"
        
        
        //Action
        switch Buttoncount {
        case 0 :
        
        let actionDefault = UIAlertAction(title: "Use all", style: .default, handler:  { [self]ACTION in D_btntf_commplete.setTitle("Use all", for: .normal); Buttoncount = 1;})
        let actionDestruction = UIAlertAction(title: "Throw away", style: .default, handler:  { [self]ACTION in D_btntf_commplete.setTitle("Throw away", for: .normal); Buttoncount = 2} )
        
            let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler:  { [self]ACTION in D_btntf_commplete.setTitle("Cancel", for: .normal); Buttoncount = 0} )
       
        // Controller와 Action 걀합
        testAlert.addAction(actionDefault)
        testAlert.addAction(actionDestruction)
        testAlert.addAction(actionCancel)
        
            //화면 띄우기
        present(testAlert, animated: true, completion: nil)
        
        case  1 : useall_Date()
            
        case  2 : Throw_Date()
            
        default: break
            
        }
        
        
    }
    //MARK: 버린 날짜 입력 함수
        func useall_Date()  {
        
            
           // if useall_throw_date(){
        let useAllModel = UseAllModel()
        let result = useAllModel.UseAllItems(u_user_no: receiveuno, u_product_no: receivepno, useCompletionDate: CurrenteDate, pname: pname)
            resultAlert(result: result)
            Buttoncount = 0 // 다시 초기화
          //  viewWillAppear(true)
          //  Throw ()
          
            self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: 사용완료 날짜 입력 함수
    func Throw_Date() {
     
     
     
        let throwModel = ThrowModel()
        let result = throwModel.ThrowItems(u_user_no: receiveuno, u_product_no: receivepno, throwDate: CurrenteDate, pname: pname)
        resultAlert(result: result)
        Buttoncount = 0 // 다시 초기화
    //    viewWillAppear(true)
      //  Throw ()
        self.navigationController?.popViewController(animated: true)
    }
    
  
    //MARK: 버린날짜, 사용완료 Alert 중복
    func resultAlert(result: Bool) {
        if result{
         
         let resultAlert = UIAlertController(title: "완료", message: "수정되었습니다", preferredStyle: .alert)
         let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
             self.navigationController?.popViewController(animated: true)
         })
         resultAlert.addAction(onAction)
         present(resultAlert, animated: true, completion: nil)
         
     }else{
         let resultAlert = UIAlertController(title: "실패", message: "에러가 발생했습니다", preferredStyle: .alert)
         let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
             self.navigationController?.popViewController(animated: true)
         })
        
         resultAlert.addAction(onAction)
         present(resultAlert, animated: true, completion: nil)
         
   
     }
    }
    
    
    //MARK: 메모 클릭시 이벤트
//    @objc func viewMapTapped(sender: UITapGestureRecognizer) {
//
//        self.performSegue(withIdentifier: "sgMeom", sender: self)
//
//
//    }

    
    //MARK: 홈뷰애서  지연님이 주실 pno 받아오는 과정
    func receiveid(item: Int){
        receivepno = item
    }
    
    //MARK: Querymodel_song로 DB 검색 : item, 및 상품이름 받아오기 위함
    override func viewWillAppear(_ animated: Bool) {
       
        let QueryDetail_ = QueryDetail()
        QueryDetail_.delegate = self
        QueryDetail_.DetaildownItems(pno: receivepno)
        print("여기는 viewcontrioller인데 QueryDetail")

       
        
        
    }
    
    //MARK: 초기 이미지,메모,item수 구해오기
    func QueryDetail_func() {
        // MARK: 홈뷰에서 넘어온 pid 정보를 보내 item값을 받아오는 곳입니다
        let item: DBDetailModel = QueryDetailItem[0] as! DBDetailModel //item값이 들어가있음
        D_lbl_item.text = ("\(item.item ?? "ss")")
       
        
        if MemoSend == "" {
            MemoSend = "\(item.memo ?? "실패")"
        D_tv_memo.text = MemoSend
        
        } else if MemoSend != ""{
            D_tv_memo.text = MemoSend
        }
  
        //MARK: 이미지 띄우는 코드
       
        let url = URL(string: "\(Share.urlIP)\(item.image ?? "싱패")")
        editimagrFilepath = "\(Share.urlIP)\(item.image ?? "싱패")"
        let data = try? Data(contentsOf: url!)
        D_imageview.image = UIImage(data: data!)
        
     //   self.D_lbl_expirationDate.textColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)//색상 변경
        D_lbl_expirationDate.text = "\(item.expirationDate ?? "실패")"
        pname = item.pname!
        D_lbl_image.text = item.pname!
        
        print("\(item.item ?? "실퍄") ,\(pname) 여기는 QueryDetail_func item을 확인하는곳이다")
        
        Throw ()
    }
    
    
    //MARK: 버린수 구하기
    func Throw () { //
           let QueryThrow_ = QueryThrow()
        QueryThrow_.delegate = self
        QueryThrow_.DetailThrowdownloadItems(pname: pname, u_user_no: receiveuno)
           print("여기는 viewcontrioller인데 Throw로 들어가는 곳")
        
       
       }
    //MARK: 버린수 구한거 출력
    func Throw2 () {

        let item: DBDetailModel = QueryThrowItem[0] as! DBDetailModel //item값이 들어가있음
        
        D_lbl_throw.text = "\(item.throwDate ?? "싪")"
        throwlist.removeAll()
        
            }
    
    
    //MARK: 구매수 구하기
    func Purchase () { //
           let QueryPurchase_ = QueryPurchase()
        QueryPurchase_.delegate = self
        QueryPurchase_.DetailPurchasedownloadItems(pname: pname, u_user_no: receiveuno)
           print("여기는 viewcontrioller인데 DetailPurchasedownloadItems로 들어가는 곳")
        
       
       }
   
    //MARK: 구매수 구한값 출력
    func Purchase2() {
    
        
        let item: DBDetailModel = DetailPurchaseItem[0] as! DBDetailModel //item값이 들어가있음
        D_lbl_purchase.text = "\(item.submitDate ?? "실패")"
        
            }
    
    
    //MARK: 등록 날짜 구하기
    func registration () { //
           let  registrationdateModel =  RegistrationdateModel()
        registrationdateModel.delegate = self
        registrationdateModel.RegistrationdatedownloadItems(s_product_no: receivepno, s_user_no: receiveuno)
           print("여기는 viewcontrioller인데 registration로 들어가는 곳")

       }
    //MARK: 등록 날짜 구하기
    func registration2()  {
        let item: DBDetailModel = RegistrationItem[0] as! DBDetailModel //item값이 들어가있음
        D_lbl_registered.text = "\(item.submitDate ?? "실패")"
    }
    
    // 메모 업데이트 실행 버튼
    @IBAction func D_btn_memoUpdate(_ sender: UIBarButtonItem) {
        memoUpdate()
    }
    
    //메모 업데이트
    func memoUpdate()  {
        let memoUpdateModel = MemoUpdateModel()
        let result = memoUpdateModel.MemoUpdateItems(pno: receivepno, memo: MemoSend)
        resultAlert(result: result)
        self.navigationController?.popViewController(animated: true)
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    }
   

    
//ViewController




extension DetailItemViewController : QueryDetailProtocol{
 
    func itemDownloaded(items: NSMutableArray, locationcont : Int) { //NSArray(배열 중 제일큰것) : 타입 꼭 지정안해도 ok..!?
        QueryDetailItem = items //가져온 data 가 들어올거임!
        
        self.QueryDetailcount = locationcont
        
        QueryDetail_func() // item,이랑 이름 값 받아온거 출력하는  함수
      
    }


}

 /// 버린 수 구하는 곳
extension DetailItemViewController: QueryThrowProtocol{
    
    func DetailTrowitemDownloaded(items: NSMutableArray, locationcont : Int) { //NSArray(배열 중 제일큰것) : 타입 꼭 지정안해도 ok..!?
        QueryThrowItem = items //가져온 data 가 들어올거임!

        self.QueryTrowcount = locationcont
        Throw2 () // 가져온 값들을 출력
        
        Purchase () // 구매수 구하기 위한 쿼리 시작
        
  
    }
}
 //구매수 구하기
extension DetailItemViewController: QueryPurchaseProtocol{
    
    func DetailPurchaseitemDownloaded(items: NSMutableArray, locationcont : Int) { //NSArray(배열 중 제일큰것) : 타입 꼭 지정안해도 ok..!?
        DetailPurchaseItem = items //가져온 data 가 들어올거임!

        self.QueryPurchasecount = locationcont
        Purchase2() // 가져온값들 출력
        registration ()
    }
}

//구매날짜

extension DetailItemViewController: RegistrationdateProtocol{
    
    func RegistrationdateitemDownloaded(items: NSMutableArray, locationcont : Int) { //NSArray(배열 중 제일큰것) : 타입 꼭 지정안해도 ok..!?
        RegistrationItem = items //가져온 data 가 들어올거임!

        registration2()
        
  
    }
}



    // MemoViewController에서 넘어온 값 받아오기
extension DetailItemViewController: MemoEdit{
    func didMessageEditDone(_ controller: MemoViewController, message: String) {
        MemoSend = message
        
        
    }
}
    





    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


