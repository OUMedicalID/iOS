//
//  HelperFunctions.swift
//  SeniorProj
//
//  Created by 2ndGen on 1/28/21.
//

import Foundation
import UIKit
import CryptoSwift

class HelperFunctions{
    
    private let secretKey = "81dc9bdb52d04dc20036dbd8313ed055"
    private let secretIV = "0000000000000000"
    
    func showAlert(title: String, msg: String, controller: UIViewController){
       
                let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    // Encrypt Data
    
    func encryptData(data: String) -> String{
          let input: Array<UInt8> = Array(data.utf8)
          let key: Array<UInt8> = Array(secretKey.utf8)
          let iv: Array<UInt8> = Array(secretIV.utf8)
          
          do {
              let encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).encrypt(input)
              let data = NSData(bytes: encrypted, length: encrypted.count)
              let base64Data = data.base64EncodedData(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
             
              if let string = String(bytes: base64Data, encoding: .utf8) {
                  return string // WE SHOULD END UP HERE.
              }
              
          } catch {
              print(error)
          }
          return "ERROR" // WE MUST HANDLE THIS. WE SHOULD NEVER END UP HERE.
      }
    
    // Decrypt Data
    func decryptData(data: String) -> String{
           let key: Array<UInt8> = Array(secretKey.utf8)
           let iv: Array<UInt8> = Array(secretIV.utf8)
           let newData = NSData(base64Encoded: data, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
           let array = [UInt8](newData)
           
           
           do {
               let decrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).decrypt(array)
               if let string = String(bytes: decrypted, encoding: .utf8) {
                   print(string) //WE SHOULD END UP HERE.
               }
               
           } catch {
               print(error)
           }
           return "ERROR" // WE MUST HANDLE THIS. WE SHOULD NEVER END UP HERE.
       }
    
    
    func prepareData(){
        // This is a function we use in the future to prepare data to be sent to server.
        let defaults = UserDefaults.standard
        let information = [
            "name":      defaults.string(forKey: "name"),
            "birthday":  defaults.object(forKey: "birthday"),
            "gender":    defaults.string(forKey: "gender"),
            "address1":  defaults.string(forKey: "address1"),
            "address2":  defaults.string(forKey: "address2"),
            "EContact1": defaults.dictionary(forKey: "EContact1")
        ]
        
        print(information)
    }
    
    
}

