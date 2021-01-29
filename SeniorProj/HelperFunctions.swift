//
//  HelperFunctions.swift
//  SeniorProj
//
//  Created by 2ndGen on 1/28/21.
//

import Foundation
import UIKit

class HelperFunctions{
    
    
    func showAlert(title: String, msg: String, controller: UIViewController){
       
                let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                controller.present(alert, animated: true, completion: nil)
    }
    
    
}

