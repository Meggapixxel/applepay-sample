//
//  ViewController.swift
//  ApplePayExample
//
//  Created by Vladyslav Vcherashnii on 11/5/18.
//  Copyright © 2018 Stfalcon. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {
    
    // MARK - Properties
    
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.stfalcon.com.applepayexample"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["UA"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "UA"
        request.currencyCode = "UAH"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iPhone Xs 64 Gb", amount: 34999.99)]
        return request
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - @IBActions
    
    @IBAction func purchase(_ sender: Any?) {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

