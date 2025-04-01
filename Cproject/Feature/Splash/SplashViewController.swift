//
//  SplashViewController.swift
//  Cproject
//
//  Created by wodnd on 3/30/25.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var appIconCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var appIconCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var appIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        ///가운데 정렬된 기점이 0이고 view frame의 반 만큼 이동하는 것
//        appIconCenterXConstraint.constant = -(view.frame.width / 2) - (appIcon.frame.width / 2)
//        appIconCenterYConstraint.constant = -(view.frame.height / 2) - (appIcon.frame.height / 2)
//        
//        ///Auto Layout의 제약을 변경한 뒤 layoutIfNeeded()로 새로운 제약을 적용하기 위해 animate함수 안에 호출한 예시
//        ///layoutIfNeeded이거는 앱 뷰가 갱신이 되고 나서 변경된 사항을 갱신해달라는 의미
//        UIView.animate(withDuration: 1) { [weak self] in
//            self?.view.layoutIfNeeded()
//        }
//        
        ///아이콘의 transform속성을 변경하는 것이기에 바로 적용하는 것이기에 animate안에 적용한 예시
        UIView.animate(withDuration: 2) { [weak self] in
            let rotationAngle: CGFloat = CGFloat.pi
            self?.appIcon.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: {$0.isKeyWindow}) {
                window.rootViewController = viewController
            }
        }
    }

}
