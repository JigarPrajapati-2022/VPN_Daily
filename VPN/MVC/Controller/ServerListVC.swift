//
//  ServerListVC.swift
//  VPN
//
//  Created by Developer on 03/01/22.
//

import UIKit
//import SwiftyJSON
class ServerListVC: UIViewController {

    
    var CountryImg:[UIImage] = [#imageLiteral(resourceName: "Canada"),#imageLiteral(resourceName: "India"),#imageLiteral(resourceName: "US"),#imageLiteral(resourceName: "Germany"),#imageLiteral(resourceName: "sweden"),#imageLiteral(resourceName: "UK")]
     
    var CountryName:[String] = ["Caneda","India","United States","Germany","Sweden","United Kingdom"]
    
    @IBOutlet weak var serverTbl: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        serverTbl.delegate = self
        serverTbl.dataSource = self
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

extension ServerListVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serverCell", for: indexPath) as! serverCell
//        cell.subView.cornerRadius = 15
        
        
        
        if selectedContryIndex == indexPath.row {
            cell.subView.borderWidth = 2.0
            cell.subView.borderColor = AppColors.PinkAppColor
        } else {
            cell.subView.borderWidth = 0.0
            cell.subView.borderColor = AppColors.BlackColor
        }
        cell.subView.layer.masksToBounds = true
        cell.subView.layer.cornerRadius = 15
        
        cell.serverImg.image = countriesData[indexPath.row].countryImage
        cell.serverName.text = countriesData[indexPath.row].name
        cell.serverSignel.image =  countriesData[indexPath.row].flag
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
            if  UserDefaultsManager().purchaseStatus == true {
                selectedContryIndex = indexPath.row
                
                serverAddress = countriesData[selectedContryIndex].serverAddressArr
                ovpnFile = countriesData[selectedContryIndex].serverName
                username = countriesData[selectedContryIndex].serverUser
                pass = countriesData[selectedContryIndex].serverPass
                serverImage = countriesData[selectedContryIndex].countryImage

                UserDefaultsManager().serverSelectedIndex = selectedContryIndex
                UserDefaultsManager().serverName = countriesData[selectedContryIndex].name
                UserDefaultsManager().serverAddress = serverAddress
                UserDefaultsManager().serverVPNFile = ovpnFile
                UserDefaultsManager().serverUser = username
                UserDefaultsManager().serverPassword = pass
                self.navigationController?.popViewController(animated: true)
                
            } else {
                let subscrptionVC = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
                subscrptionVC.isWhereToCome = "list"
                self.navigationController?.pushViewController(subscrptionVC, animated: true)
            }
        
    }
}

class serverCell:UITableViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var serverName: UILabel!
    
    @IBOutlet weak var serverKingImg: UIImageView!
    @IBOutlet weak var serverSignel
        : UIImageView!
    @IBOutlet weak var serverSubname: UILabel!
    @IBOutlet weak var serverImg: UIImageView!
    override func awakeFromNib() {
        
    }
}
