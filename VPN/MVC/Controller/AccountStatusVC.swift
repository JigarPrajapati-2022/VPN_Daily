//
//  AccountStatusVC.swift
//  VPN
//
//  Created by Developer on 04/01/22.
//

import UIKit

class AccountStatusVC: UIViewController {

    @IBOutlet weak var UpgradsubView: UIView!
    @IBOutlet weak var upgradBtn: UIButton!
    @IBOutlet weak var freeOrPaidMemberShipLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaultsManager().purchaseStatus ??  true {
            freeOrPaidMemberShipLbl.text = "PAID MEMBERSHIP"
        } else {
            freeOrPaidMemberShipLbl.text = "FREE MEMBERSHIP"

        }
        
        UpgradsubView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 15)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func upgradBtnTap(_ sender: UIButton) {
        let subScriptionVC = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
        subScriptionVC.isWhereToCome = "list"

      self.navigationController?.pushViewController(subScriptionVC, animated: true)
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
