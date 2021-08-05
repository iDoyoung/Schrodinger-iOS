//
//  SignInViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/29.
//

import UIKit

import KakaoSDKAuth // MARK: Kakao Login - 토큰 존재 여부 확인
import KakaoSDKUser // MARK: Kakao Login - 로그인 실행, 토큰 가져오기, 사용자 정보 관리, 사용자 정보 가져오기
import KakaoSDKCommon // MARK: Kakao Login - 토큰 존재 여부 확인 시 Error 처리

import Firebase // MARK: Firebase 초기화
import GoogleSignIn // MARK: Google Login


let myUserDefaults = UserDefaults.standard // MARK: Email(id) UserDefault 선언
let usernoUserDefaults = UserDefaults.standard // MARK: User Number(userno) UserDefault 선언

class SignInViewController: UIViewController {

//    let myUserDefaults = UserDefaults.standard
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: Email UserDefault Label에 띄우기
        //        infoLabel.text = Share.userID
                infoLabel.text = myUserDefaults.string(forKey: "userEmail")
        //        infoLabel.text = UserDefaults.standard.string(forKey: "userEmail")
        
        
        // MARK: Kakao Login - Email 필수동의 Alert 띄우기
        if myUserDefaults.string(forKey: "userEmail") == "방문자" {
            
            infoLabel.text = myUserDefaults.string(forKey: "userEmail")
            let idAlert = UIAlertController(title: "주의", message: "카카오 로그인은 이메일 제공 동의 필수", preferredStyle: .alert)
            let idAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            idAlert.addAction(idAction)
            present(idAlert, animated: true, completion: nil)
            
        }else{
            
            // MARK: Kakao Login - 토큰 존재 여부 확인
            // MARK: Kakao Login - Login email 확인
            if (AuthApi.hasToken() && myUserDefaults.string(forKey: "userEmail") != "방문자") {
                UserApi.shared.accessTokenInfo { (_, error) in
                    if let error = error {
                        if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                            //로그인 필요
                        }
                        else {
                            //기타 에러
                        }
                    }
                    else {
                        //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                        // MARK: Kakao Login - 자동 로그인
                        let storyboard = UIStoryboard(name: "JyKim", bundle: nil)
                        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
                        self.present(destinationVC, animated: true, completion: nil)
                    }
                }
            }
            else {
                //로그인 필요
            }
            
        }
        
    }
    
    // MARK: Kakao Login - 카카오 로그인 버튼에 대한 로직 추가
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
     // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
        // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
        // MARK: Kakao Login - 카카오톡 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                    // 어세스토큰
//                    let accessToken = oauthToken?.accessToken
                    //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                    // MARK: Kakao Login 성공 후 마이페이지 띄우기
                    let storyboard = UIStoryboard(name: "JyKim", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
                    self.present(destinationVC, animated: true, completion: nil)
                }
                
            }

        }else{
            // MARK: Kakao Login - 웹으로 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                    // MARK: Kakao Login 성공 후 마이페이지 띄우기
                    let storyboard = UIStoryboard(name: "JyKim", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
                    self.present(destinationVC, animated: true, completion: nil)
                    

                }
                
            }

        }

    
    }
    
    // MARK: Kakao Login - 사용자 정보 가져오기
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
//                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname

                // MARK: Kakao Login - user email 받아 UserDefault에 등록
//                myUserDefaults.set(user?.kakaoAccount?.email, forKey: "userEmail")
                if user?.kakaoAccount?.email != nil {
                    myUserDefaults.set(user?.kakaoAccount?.email, forKey: "userEmail")
                }else{
                    myUserDefaults.set("방문자", forKey: "userEmail")
                }
//                if user?.kakaoAccount?.email != nil {
//                    Share.userID = (user?.kakaoAccount?.email)!
//                }else{
//                    Share.userID = "방문자"
//                }
                
//                self.infoLabel.text = Share.userID
                self.infoLabel.text = myUserDefaults.string(forKey: "userEmail")
                
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
                

            }
        }

    }
    
    // MARK: Google Login - 구글 로그인 버튼에 대한 로직 추가
    @IBAction func btnGoogleLogin(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

            if let error = error {
                // ...
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
        
            // ...
            
            // MARK: Google Login 성공 후 마이페이지 띄우기
            let storyboard = UIStoryboard(name: "JyKim", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
            self.present(destinationVC, animated: true, completion: nil)
            
            
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

}



