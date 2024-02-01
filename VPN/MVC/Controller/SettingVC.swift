//
//  SettingVC.swift
//  VPN
//
//  Created by Developer on 03/01/22.
//

import UIKit

class SettingVC: UIViewController {

    
    @IBOutlet weak var privacyPolicyBtn: UIButton!
    @IBOutlet weak var accountStatus: UIButton!
    @IBOutlet weak var TCBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func accountStatusBtnTap(_ sender: UIButton) {
        
        let accountStatusVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatusVC") as! AccountStatusVC
        
        self.navigationController?.pushViewController(accountStatusVC, animated: true)
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
        
//        let formVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackFormVC") as! FeedbackFormVC
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
