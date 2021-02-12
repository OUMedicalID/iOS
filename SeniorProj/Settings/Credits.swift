import UIKit
import Eureka

class Credits: FormViewController {
     
     override func viewDidLoad() {
         self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         
       
      
        
        
         form +++ Section("App Developers")
            
            <<< LabelRow("password") {
                $0.title = "John"
                $0.value = "Developer"
                
            }
        
            <<< TextRow("confirm") {
                $0.title = "Confirm Password"
                $0.placeholder = "Confirm Password"
            }
        
           

        
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }


