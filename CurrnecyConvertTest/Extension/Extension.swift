//
//  Extension.swift
//  CurrnecyConvertTest
//
//  Created by EZAZ AHAMD on 06/03/23.
//

import UIKit


extension UIViewController {
    func showAlertWithTitleMessageAndButtonTextWithHandling(title: String, message: String, buttonTitles: [String]?, completion: [((UIAlertAction) -> Void)?]) ->UIAlertController
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (i,v) in (buttonTitles?.enumerated())! {
            alertVC.addAction(UIAlertAction(title: v, style: .default, handler: completion[i]))
        }
        DispatchQueue.main.async {
            
            self.present(alertVC, animated: true, completion: nil)
        }
        
        return alertVC
    }
}
