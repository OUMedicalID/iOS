import UIKit
import Eureka

class Credits: FormViewController {
     
     override func viewDidLoad() {
         self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         
        
        
        
        
         form +++ Section("App Developers")
            
            <<< LabelRow() {
                $0.title = "Mathew Yaldo"
                $0.value = "IOS & Android Developer"
                
            }
         
            <<< LabelRow() {
                $0.title = "Aryan Abdolhosseini"
                $0.value = "IOS Developer"
                
            }
        
            <<< LabelRow() {
                $0.title = "Adrian Berishaj"
                $0.value = "IOS Developer"
                
            }
        
            <<< LabelRow() {
                $0.title = "Yousif Hanani"
                $0.value = "Android Developer"
                
            }
        
            <<< LabelRow() {
                $0.title = "Tin Liu"
                $0.value = "Android Developer"
                
            }
           
        
        
        form +++ Section("Libraries and Frameworks")
           
           <<< LabelRow() {
               $0.title = "NFCReaderWriter"
               
           }
        
           <<< LabelRow() {
               $0.title = "Eureka"
               
           }
       
           <<< LabelRow() {
               $0.title = "CryptoSwift"
               
           }
       
           <<< LabelRow() {
               $0.title = "CRDCrypt"
               
           }
       
           <<< LabelRow() {
               $0.title = "BiometricAuthentication"
               
           }

        
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }


