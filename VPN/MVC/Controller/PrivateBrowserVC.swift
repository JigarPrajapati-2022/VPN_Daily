//
//  PrivateBrowserVC.swift
//  VPN
//
//  Created by Developer on 04/01/22.
//

import UIKit
import WebKit
import SwiftWebVC

class PrivateBrowserVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate,SwiftWebVCDelegate  {

    
    func didStartLoading() {
        showActivityWithMessage(message: "", inView: self.view)
    }
    func didFinishLoading(success: Bool) {
        if success {
            hideActivity()
        }
        
    }
    
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchTxt: DesignableUITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBgView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 15)
        // Do any additional setup after loading the view.
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//
//        return true
//    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func searchBtnTap(_ sender: UIButton) {
        let webVC = SwiftModalWebVC(urlString: "https://google.com/search?q=\(searchTxt.text ?? "")".replacingOccurrences(of: " ", with: "%20"),theme: .lightBlue, dismissButtonStyle: .cross,sharingEnabled: true)
        webVC.delegate = self
        
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true, completion: nil)
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
