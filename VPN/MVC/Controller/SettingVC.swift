//
//  SettingVC.swift
//  VPN
//
//  Created by Developer on 03/01/22.
//

import UIKit
import StoreKit

class SettingVC: UIViewController {

    
    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var privacyPolicyBtn: UIButton!
    @IBOutlet weak var RecommandAppBtn: UIButton!
    @IBOutlet weak var TCBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func purchaseBtnPress(_ sender: UIButton) {
                let subScriptionVC = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
                subScriptionVC.isWhereToCome = "list"
        
              self.navigationController?.pushViewController(subScriptionVC, animated: true)
    }
    
    @IBAction func rateBtnAction(_ sender: UIButton) {
        let twoSecondsFromNow = DispatchTime.now() + 2.0
               DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) {
                       SKStoreReviewController.requestReview()
               }
    }
    
    
    @IBAction func RecommandAppBtnTap(_ sender: UIButton) {
        //Share App
        
        if let urlStr = NSURL(string: "https://apps.apple.com/us/app/vpn-daily/id1572986681?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }
        
//        let accountStatusVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatusVC") as! AccountStatusVC
//        
//        self.navigationController?.pushViewController(accountStatusVC, animated: true)
    }
    @IBAction func PrivacyBtnTap(_ sender: UIButton) {
        
//        let privateBrowserVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateBrowserVC") as! PrivateBrowserVC
//
//        self.navigationController?.pushViewController(privateBrowserVC, animated: true)
        
        
        let PrivacyPolicyVC  = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyTermsConditionVC") as! PrivacyTermsConditionVC
        PrivacyPolicyVC.HeaderTitle = "PRIVACY POLICY".uppercased()
        self.navigationController?.pushViewController(PrivacyPolicyVC, animated: true)
        
    }
    @IBAction func TandCBtn(_ sender: UIButton) {
        let PrivacyPolicyVC  = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyTermsConditionVC") as! PrivacyTermsConditionVC
        PrivacyPolicyVC.HeaderTitle = "terms and conditions".uppercased()
        self.navigationController?.pushViewController(PrivacyPolicyVC, animated: true)
    }
    
    @IBAction func feedBackBtnTap(_ sender: UIButton) {
        
//        let formVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackFormVC") as! Feed
//        self.navigationController?.pushViewController(formVC, animated: true)
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
