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
    
    public let domain = "https://med.mathew.me" // To be changed soon...
    
    
    
    public let states = ["Alabama","Alaska","American Samoa","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District of Columbia","Federated States of Micronesia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Marshall Islands","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Northern Mariana Islands","Ohio","Oklahoma","Oregon","Palau","Pennsylvania","Puerto Rico","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virgin Island","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    
    
    private let defaults = UserDefaults.standard
    
    
    
    private var secretKey = ""
    private let secretIV = "0000000000000000"
    
    
    
    
    
    func showAlert(title: String, msg: String, controller: UIViewController){
                let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    // Encrypt Data
    
    func encryptData(data: String) -> String{
        
          secretKey = defaults.string(forKey: "sha512Key")!
          let input: Array<UInt8> = Array(data.utf8)
          let key: Array<UInt8> = Array(secretKey.utf8)
          let iv: Array<UInt8> = Array(secretIV.utf8)
          
          do {
              let encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).encrypt(input)
              let data = NSData(bytes: encrypted, length: encrypted.count)
            
              return data.hexEncodedString().uppercased()
              
          } catch {
              print(error)
          }
          return "ERROR" // WE MUST HANDLE THIS. WE SHOULD NEVER END UP HERE.
      }
    
    
    
    func encryptData2(data: String, key: String) -> String{
        
          let input: Array<UInt8> = Array(data.utf8)
          let key: Array<UInt8> = Array(key.utf8)
          let iv: Array<UInt8> = Array(secretIV.utf8)
          
          do {
              let encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).encrypt(input)
              let data = NSData(bytes: encrypted, length: encrypted.count)
            
              return data.hexEncodedString().uppercased()
              
          } catch {
              print(error)
          }
          return "ERROR" // WE MUST HANDLE THIS. WE SHOULD NEVER END UP HERE.
      }
    
    
    
    // Decrypt Data
    func decryptData(data: String) -> String{
        
            print("Data that we received: "+data)
            if let key = defaults.string(forKey: "sha512Key"){
                secretKey = key
            }else{
                secretKey = ""
            }
           let key: Array<UInt8> = Array(secretKey.utf8)
           let iv: Array<UInt8> = Array(secretIV.utf8)
           let newData =  data.data(using: .hexadecimal)
           //if (newData == nil) {return "Report: "+newData}
           let array = [UInt8](newData!)
           
           
           do {
               let decrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).decrypt(array)
               if let string = String(bytes: decrypted, encoding: .utf8) {
                   print(string) //WE SHOULD END UP HERE.
                return string
                
               }
               
           } catch {
               print(error)
           }
           return "ERROR" // WE MUST HANDLE THIS. WE SHOULD NEVER END UP HERE.
       }
    
    
    
    
    func sha512(password: String) -> String{
        return password.sha512()
    }
    
    func showAllValues(){
        print("Now printing all UserDefaults")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("\(key) = \(value) \n")
        }
    }
    
    
    
    
}


extension NSData {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}


extension String {
       enum ExtendedEncoding {
           case hexadecimal
       }

       func data(using encoding:ExtendedEncoding) -> Data? {
           let hexStr = self.dropFirst(self.hasPrefix("0x") ? 2 : 0)

           guard hexStr.count % 2 == 0 else { return nil }

           var newData = Data(capacity: hexStr.count/2)

           var indexIsEven = true
           for i in hexStr.indices {
               if indexIsEven {
                   let byteRange = i...hexStr.index(after: i)
                   guard let byte = UInt8(hexStr[byteRange], radix: 16) else { return nil }
                   newData.append(byte)
               }
               indexIsEven.toggle()
           }
           return newData
       }
   }
