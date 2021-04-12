import UIKit
import Eureka

class Credits: FormViewController {
     
     override func viewDidLoad() {
         self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         
        
        
        
        
         form +++ Section("App Developers")
            
            <<< LabelRow() {
                $0.title = "Mathew Yaldo"
                $0.value = "Developer"
                
            }
            
            <<< LabelRow() {
                $0.title = "Tin Liu"
                $0.value = "Developer"
                
            }
         
            <<< LabelRow() {
                $0.title = "Aryan Abdolhosseini"
                $0.value = "Developer"
                
            }
        
            <<< LabelRow() {
                $0.title = "Adrian Berishaj"
                $0.value = "Developer"
                
            }
        
            <<< LabelRow() {
                $0.title = "Yousif Hanani"
                $0.value = "Developer"
                
            }
        
           
        
        
        form +++ Section("Libraries and Frameworks")
           
           <<< LabelRow() {
               $0.title = "NFCReaderWriter"
               
           }.onCellSelection({ [unowned self] (cell, row) in
            _ = self
            
            if let url = URL(string: "https://github.com/janlionly/NFCReaderWriter") {
                UIApplication.shared.open(url)
            }
            
           }).cellSetup() { cell, row in
            cell.accessoryType = .disclosureIndicator
          }
           
            
           <<< LabelRow() {
               $0.title = "Eureka"
               
           }.onCellSelection({ [unowned self] (cell, row) in
            _ = self
            
            if let url = URL(string: "https://github.com/xmartlabs/Eureka") {
                UIApplication.shared.open(url)
            }
            
           }).cellSetup() { cell, row in
            cell.accessoryType = .disclosureIndicator
          }
       
            
           <<< LabelRow() {
               $0.title = "CryptoSwift"
               
           }.onCellSelection({ [unowned self] (cell, row) in
            _ = self
    
            if let url = URL(string: "https://github.com/krzyzanowskim/CryptoSwift") {
                UIApplication.shared.open(url)
            }
    
            }).cellSetup() { cell, row in
            cell.accessoryType = .disclosureIndicator
            }
       
            
           <<< LabelRow() {
               $0.title = "CRDCrypt"
               
           }.onCellSelection({ [unowned self] (cell, row) in
            _ = self
    
            if let url = URL(string: "https://github.com/cdisdero/CRDCrypt") {
                UIApplication.shared.open(url)
            }
    
            }).cellSetup() { cell, row in
            cell.accessoryType = .disclosureIndicator
            }
       
            
           <<< LabelRow() {
               $0.title = "BiometricAuthentication"
               
           }.onCellSelection({ [unowned self] (cell, row) in
            _ = self
    
            if let url = URL(string: "https://github.com/rushisangani/BiometricAuthentication") {
                UIApplication.shared.open(url)
            }   
    
            }).cellSetup() { cell, row in
            cell.accessoryType = .disclosureIndicator
            }

        
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }


