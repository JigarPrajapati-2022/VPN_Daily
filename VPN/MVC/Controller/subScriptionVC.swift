//
//  subScriptionVC.swift
//  VPN
//
//  Created by Developer on 04/01/22.
//

import UIKit

class subScriptionVC: UIViewController {

    var delegate:SubScriptionProtocol?
    var selectedOption = -1

    @IBOutlet weak var continueBtn: UIButton!
    
    
    
    
    @IBOutlet weak var firstDiccountLbl: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstTopView: UIView!
    @IBOutlet weak var firstTimeLbl: UILabel!
    @IBOutlet weak var firstPriceLbl: UILabel!
    @IBOutlet weak var firstBtn: UIButton!
    
    @IBOutlet weak var SecondDiccountLbl: UILabel!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var secondTopView: UIView!
    @IBOutlet weak var secondTimeLbl: UILabel!
    @IBOutlet weak var secondPriceLbl: UILabel!
    @IBOutlet weak var secondBtn: UIButton!
    
    @IBOutlet weak var ThirdDiccountLbl: UILabel!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var thirdTopView: UIView!
    @IBOutlet weak var thirdTimeLbl: UILabel!
    @IBOutlet weak var thirdPriceLbl: UILabel!
    @IBOutlet weak var thirdBtn: UIButton!
    
    
    @IBOutlet weak var restoreBtn: UIButton!
    @IBOutlet weak var TopCorner: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    var isWhereToCome = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
            firstView.borderWidth = 1.5
            secondView.borderWidth = 1.5
            thirdView.borderWidth = 1.5
        
        
        
        if isWhereToCome == "list" {
            closeBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        } else {
            closeBtn.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
        }
        
        firstTopView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 0)
        secondTopView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 0)
        thirdTopView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 0)
        
        
        continueBtn.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 10)
        
        if UserDefaultsManager().purchasePlan == IPAProduct.Mounth.rawValue {
            selectSubScriptionOption(option: 2)
        } else if UserDefaultsManager().purchasePlan == IPAProduct.Week.rawValue {
            selectSubScriptionOption(option: 1)
        } else if UserDefaultsManager().purchasePlan == IPAProduct.Yearly.rawValue {
            selectSubScriptionOption(option: 3)
        } else {
            selectSubScriptionOption(option: 1)
        }
        
        
        if UserDefaultsManager().weeklyPrice == "" && UserDefaultsManager().monthlyPrice == "" && UserDefaultsManager().yearlyPrice == ""  {
            DispatchQueue.main.async {
                IPASubScriptionService.shared.getProduct()
                self.firstPriceLbl.text = "\(UserDefaultsManager().weeklyPrice ?? "")"
                self.secondPriceLbl.text = "\(UserDefaultsManager().monthlyPrice ?? "")"
                self.thirdPriceLbl.text = "\(UserDefaultsManager().yearlyPrice ?? "")"
                
                self.firstDiccountLbl.text = "\(contrySy) \(UserDefaultsManager().weeklyOfferPrice ?? "") /per week"
                self.SecondDiccountLbl.text = "\(contrySy) \(UserDefaultsManager().monthlyOfferPrice ?? "") /per week"
                self.ThirdDiccountLbl.text = "\(contrySy) \(UserDefaultsManager().yearlyOfferPrice ?? "") /per week"
                
            }
            
        } else {
            firstPriceLbl.text = "\(UserDefaultsManager().weeklyPrice ?? "")"
            secondPriceLbl.text = "\(UserDefaultsManager().monthlyPrice ?? "")"
            thirdPriceLbl.text = "\(UserDefaultsManager().yearlyPrice ?? "")"
            
            firstDiccountLbl.text = "\(contrySy) \(UserDefaultsManager().weeklyOfferPrice ?? "") /per week"
            SecondDiccountLbl.text = "\(contrySy) \(UserDefaultsManager().monthlyOfferPrice ?? "") /per week"
            ThirdDiccountLbl.text = "\(contrySy) \(UserDefaultsManager().yearlyOfferPrice ?? "") /per week"
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func restoreBtn(_ sender: UIButton) {
        showActivityWithMessage(message: "Loading...", inView: self.view)

        IPASubScriptionService.shared.restorePurchases()
    }
    @IBAction func firstBtnTap(_ sender: UIButton) {
        selectSubScriptionOption(option: 1)
    }
    @IBAction func secondBtnTap(_ sender: UIButton) {
        selectSubScriptionOption(option: 2)
    }
    @IBAction func thirdBtnTap(_ sender: UIButton) {
        selectSubScriptionOption(option: 3)
    }
    
    @IBAction func closeBtnTap(_ sender: UIButton) {
        if isWhereToCome == "list" {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    func selectSubScriptionOption(option:Int) {
        print("option \(option)")
        selectedOption = option
        switch  option {
        case 1:
            firstView.borderWidth = 1.5
            secondView.borderWidth = 1.5
            thirdView.borderWidth = 1.5
            
            
            
            firstView.borderColor = AppColors.PinkAppColor
            secondView.borderColor = .clear
            thirdView.borderColor = .clear
            break
        case 2:
            firstView.borderColor = .clear
            secondView.borderColor = AppColors.PinkAppColor
            thirdView.borderColor = .clear
            break
        case 3:
            firstView.borderColor = .clear
            secondView.borderColor = .clear
            thirdView.borderColor = AppColors.PinkAppColor
            break
        default:
            break
        }
    }

    
    @IBAction func continueBtnTap(_ sender: UIButton) {
        purchesPlan()
    }
    
    func purchesPlan() {
            if selectedOption == -1 {
                showAlet(message: "please select Subscription plan", Title: "Warnning!", controller: self) { status in
                    
                }
            } else {
                switch selectedOption {
                case 1:
                    //week
                    showActivityWithMessage(message: "Loading...", inView: self.view)
                    IPASubScriptionService.shared.purchase(product: .Week)
                    break
                case 2:
                    //mounth
                    showActivityWithMessage(message: "Loading...", inView: self.view)
                    IPASubScriptionService.shared.purchase(product: .Mounth)
                    break
                case 3:
                    //mounth
                    showActivityWithMessage(message: "Loading...", inView: self.view)
                    IPASubScriptionService.shared.purchase(product: .Yearly)
                    break
                
                default:
                    showAlet(message: "please select Subscription plan", Title: "Warnnig!", controller: self){ status in
                        
                    }
                    
                }
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
