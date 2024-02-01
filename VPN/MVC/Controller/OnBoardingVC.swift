//
//  OnBoardingVC.swift
//  VPN
//
//  Created by Developer on 03/01/22.
//

import UIKit


protocol SubScriptionProtocol {
    func GoToSubScrption()
}

class OnBoardingVC: UIViewController,SubScriptionProtocol {
    
    func GoToSubScrption() {
        let subscriptionBtnTap = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
        
        self.navigationController?.pushViewController(subscriptionBtnTap, animated: true)
    }
    
    var visibleCell = 0
    var imageList:[UIImage] = [#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3")]
    let infoString:[String] = [
                            "SAFE & SECURE".uppercased(),
                               "private browser".uppercased(),
//                               "Ads free services".uppercased(),
                               "Unlimited Servers".uppercased()
    ]
    
    let infoSubString:[String] = [
        "Worried about your privacy, Get a VPN installed to be worry-free from getting a share of your privacy data.",
        "Get access to custome browser, where you can explore without worrting share of your Private data.",
//        "Enjoy an Uninterruped and Lighting fast exploring experience.",
        "Get an enriched experience with our number of servers."]
    @IBOutlet weak var ContinueBtn: UIButton!
    @IBOutlet weak var startCollection: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCollection.delegate  = self
        startCollection.dataSource  = self
        pageController.numberOfPages = imageList.count
        

        
//        
//                  let initialVC = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
////                  initialVC.modalPresentationStyle = .popover
//                  initialVC.delegate = self
//                  self.present(initialVC, animated: true) {
//                      print("done ")
//                  }
//              
//        
        
//        self.ContinueBtn.setTitle("Next".uppercased(), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    func scrollAutomatically() {
         if visibleCell == 0 {
            UIView.animate(withDuration: 0.2) {
                self.startCollection.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
            } completion: { (true) in
                self.pageController.currentPage = 1
                self.visibleCell = 1
//                self.ContinueBtn.setTitle("Next".uppercased(), for: .normal)
            }
        } else if visibleCell == 1 {
            UIView.animate(withDuration: 0.2) {
                self.startCollection.contentOffset = CGPoint(x: UIScreen.main.bounds.width*2, y: 0)
            } completion: { (true) in
                self.pageController.currentPage = 2
                self.visibleCell = 2
//                self.ContinueBtn.setTitle("Next".uppercased(), for: .normal)
            }
            
        
        } else if visibleCell == 2 {
            UIView.animate(withDuration: 0.2) {
                self.startCollection.contentOffset = CGPoint(x: UIScreen.main.bounds.width*3, y: 0)
            } completion: { (true) in
                self.pageController.currentPage = 3
                self.visibleCell = 3
//                self.ContinueBtn.setTitle("Get started".uppercased(), for: .normal)
            }
        }
            
            
        
    }
    @IBAction func SkipBtn(_ sender: UIButton) {
        UserDefaultsManager().isFirstTime = true

AppDelegate.sharedAppDelegate.goToRootView()

    }
    @IBAction func Continue(_ sender: UIButton) {
        
        if visibleCell < 3 {
            scrollAutomatically()
        } else {
//            ServerListVC
                        UserDefaultsManager().isFirstTime = true
//            let severList = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//            self.navigationController?.pushViewController(severList, animated: true)

            AppDelegate.sharedAppDelegate.goToRootView()
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


extension OnBoardingVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = self.startCollection.contentOffset.x / self.startCollection.frame.size.width
        visibleCell = Int(index)
        self.pageController.currentPage = Int(index)
        
        if visibleCell == 3  {
            self.ContinueBtn.setTitle("Get started".uppercased(), for: .normal)
        } else {
            self.ContinueBtn.setTitle("Next".uppercased(), for: .normal)
        }
        
//        scrollAutomatically()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trialInfoCell", for: indexPath) as! trialInfoCell
        
        cell.infoImg.image = imageList[indexPath.row]
        cell.infoLbl.text = infoString[indexPath.row]
        cell.infoSubLbl.text = infoSubString[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
}
class trialInfoCell:UICollectionViewCell {
    
    @IBOutlet weak var infoSubLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var infoImgWidth: NSLayoutConstraint!
    @IBOutlet weak var infoImg: UIImageView!
    override func awakeFromNib() {
        infoImgWidth.constant = UIScreen.main.bounds.width
    }
}


