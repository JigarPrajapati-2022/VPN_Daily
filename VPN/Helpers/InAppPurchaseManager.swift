//
//  InAppPurchaseManage.swift
//  VPN
//
//  Created by Developer on 05/01/22.
//

import Foundation

import StoreKit

enum IPAProduct: String{
    case Week = "com.VPNDaily_week"
    case Mounth  = "com.VPNDaily_month"
    case Yearly = "com.VPNDaily_year"
}

class IPASubScriptionService: NSObject {
    
    private override init() {}
    static let shared = IPASubScriptionService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProduct(){
        let products: Set = [
            IPAProduct.Week.rawValue,
            IPAProduct.Mounth.rawValue,
            IPAProduct.Yearly.rawValue,
        ]
        print("products list \(products)")
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IPAProduct){
        guard let productToPurchase = products.filter({
            $0.productIdentifier == product.rawValue
        }).first else{ return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
    func restorePurchases(){
        paymentQueue.add(self)
        paymentQueue.restoreCompletedTransactions()
    }
    
    func validateReceipt(){
        #if DEBUG
        let urlString = "https://sandbox.itunes.apple.com/verifyReceipt"
        #else
        let urlString = "https://buy.itunes.apple.com/verifyReceipt"
        #endif
        
        guard let receiptURL = Bundle.main.appStoreReceiptURL, let receiptString = try? Data(contentsOf: receiptURL).base64EncodedString() , let url = URL(string: urlString) else {
            return
        }
        
        let requestData : [String : Any] = ["receipt-data" : receiptString,
                                            "password" : "c9630ab335864defa366b3aaf730950e",
                                            "exclude-old-transactions" : true]
        let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            
            DispatchQueue.main.async{
                // convert data to Dictionary and view purchases
                if let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    // your non-consumable and non-renewing subscription receipts are in `in_app` array
                    // your auto-renewable subscription receipts are in `latest_receipt_info` array
                    print(jsonData)
                    if let dic = jsonData as? NSDictionary{
                        if let reciptArr = dic["latest_receipt_info"] as? NSArray{
                            if let reciptDic = reciptArr[0] as? NSDictionary{
                                if let expires_date = reciptDic["expires_date"] as? String{
                                    
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
                                    if let date = formatter.date(from: expires_date) {
                                        if date > Date() {
                                            // do not save expired date to user defaults to avoid overwriting with expired date
                                            UserDefaultsManager().purchasePlan = reciptDic["product_id"] as? String
                                            UserDefaultsManager().purchaseStatus = true
                                            
                                            NotificationCenter.default.post(name: .purchaseNotif, object: nil)
                                            hideActivity()
                                        }else{
                                            
                                            UserDefaultsManager().purchaseStatus = false
                                            hideActivity()
                                            NotificationCenter.default.post(name: .noRestordData, object: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }else{
                    
                    UserDefaultsManager().purchaseStatus = false
                    hideActivity()
                    NotificationCenter.default.post(name: .noRestordData, object: nil)
                }
            }
        }.resume()
    }
}

extension IPASubScriptionService: SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        self.products = response.products
        for product in response.products{
            
            print(product.productIdentifier)
            if product.productIdentifier == IPAProduct.Mounth.rawValue {
                let price = Double(truncating: product.price)/30*7
                mOfferPrice = String(format: "%.2f", price)
                print("mOfferPrice \(mOfferPrice)")
                mPrice = "\(product.price)"
                contrySy = "\(product.priceLocale.currencySymbol!)"
                fMPrice = "\(contrySy) \(mPrice)"
            } else if product.productIdentifier == IPAProduct.Week.rawValue {
                wOfferPrice = "\(product.price)"
                wPrice = "\(product.price)"
                contrySy = "\(product.priceLocale.currencySymbol!)"
                fWPrice = "\(contrySy) \(wPrice)"
            } else if product.productIdentifier == IPAProduct.Yearly.rawValue {
                let price = Double(truncating: product.price)/365*7
                yOfferPrice = String(format: "%.2f", price)
                print("yOfferPrice \(yOfferPrice)")
                yPrice = "\(product.price)"
                contrySy = "\(product.priceLocale.currencySymbol!)"
                fyPrice = "\(contrySy) \(yPrice)"
            }
        }
        
        UserDefaultsManager().weeklyOfferPrice = wOfferPrice
        UserDefaultsManager().monthlyOfferPrice = mOfferPrice
        UserDefaultsManager().yearlyOfferPrice = yOfferPrice
            
            
        UserDefaultsManager().weeklyPrice = fWPrice
        UserDefaultsManager().monthlyPrice = fMPrice
        UserDefaultsManager().yearlyPrice = fyPrice
        
    }
}

extension IPASubScriptionService: SKPaymentTransactionObserver{
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions{
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch transaction.transactionState{
            
            case .purchasing:
              
                break
                
            case .purchased:
                
               UserDefaultsManager().purchaseStatus = true
                hideActivity()
                SKPaymentQueue.default().finishTransaction(transaction)
                NotificationCenter.default.post(name: .purchaseNotif, object: nil)
                break
            case .failed:
                
                if let error = transaction.error{
                    let errorDesc = error.localizedDescription
                    print("transaction failed: \(errorDesc)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
                hideActivity()
                break
                
            case .restored:
                
                self.validateReceipt()
                
                SKPaymentQueue.default().finishTransaction(transaction)
                hideActivity()
                break
                
            case .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                hideActivity()
                break
                
            @unknown default:
                queue.finishTransaction(transaction)
                hideActivity()
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print ("This works")
        self.validateReceipt()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("restoring failed")
        hideActivity()
    }
    
}

extension SKPaymentTransactionState{
    func status() -> String{
        switch self{
        case .deferred:
            return "deferred"
        case .purchasing:
            return "purchasing"
        case .purchased:
            return "purchased"
        case .failed:
            return "failed"
        case .restored:
            return "restored"
        @unknown default:
            return "default"
        }
    }
}
