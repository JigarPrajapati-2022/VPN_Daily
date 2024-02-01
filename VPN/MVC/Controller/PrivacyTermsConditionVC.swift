//
//  PrivacyImportVC.swift
//  VPN
//
//  Created by Developer on 04/01/22.
//

import UIKit

class PrivacyTermsConditionVC: UIViewController {
    @IBOutlet weak var TermsTxt: UITextView!
    @IBOutlet weak var PrivacyTxt: UITextView!
    
    @IBOutlet weak var titleLbl: UILabel!
    var HeaderTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if HeaderTitle == "PRIVACY POLICY" {
            TermsTxt.isHidden = true
            PrivacyTxt.isHidden = false
        } else {
            TermsTxt.isHidden = false
            PrivacyTxt.isHidden = true
        }
        titleLbl.text = HeaderTitle
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
