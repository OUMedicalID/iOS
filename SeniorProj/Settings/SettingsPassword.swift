import UIKit
import Eureka

class SettingsPassword: FormViewController {
     
     override func viewDidLoad() {
         self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         let defaults = UserDefaults.standard
       
        if(defaults.string(forKey: "appPassword") != nil){
            
            form +++ Section(header: "Remove Password", footer: "Click the button above to remove the app password.")
            
                <<< ButtonRow { row in
                    row.title = "Remove Password"
                }.onCellSelection({ [unowned self] (cell, row) in
                    
                    defaults.set(nil, forKey: "appPassword")
                    dismiss(animated: true, completion: nil)
                })
            
            
        }else{
        
        
         form +++ Section("Password Authentication")
            
            <<< PasswordRow("password") {
                $0.title = "Password"
                $0.placeholder = "Enter Password"
            }
        
            <<< PasswordRow("confirm") {
                $0.title = "Confirm Password"
                $0.placeholder = "Confirm Password"
            }
        
            <<< ButtonRow { row in
                row.title = "Enable Password"
            }.onCellSelection({ [unowned self] (cell, row) in
                let passwordV  = self.form.rowBy(tag: "password") as? RowOf<String>
                let confirmV  = self.form.rowBy(tag: "confirm") as? RowOf<String>
                
                if let password = passwordV, let confirm = confirmV{
                   
                    // empty values case.
                    if(password.value == nil || confirm.value == nil){
                        HelperFunctions().showAlert(title: "Error",
                        msg: "Please fill in passwords", controller: self)
                        return
                    }
                    
                    // Passwords don't match
                    if(password.value != confirm.value){
                        HelperFunctions().showAlert(title: "Error",
                        msg: "Passwords do not match.", controller: self)
                        return
                    }
                    let pass = password.value!
                    // Passwords don't match
                    if(pass.count < 5){
                        HelperFunctions().showAlert(title: "Error",
                        msg: "Passwords must be at least 5 characters.", controller: self)
                        return
                    }
                    
                    let sha512Pass = HelperFunctions().sha512(password: password.value!)
                    defaults.set(sha512Pass, forKey: "appPassword")
                   // HelperFunctions().showAlert(title: "Success",msg: "Password Set", controller: self)
                    
                    navigationController?.popViewController(animated: true)
                    dismiss(animated: true, completion: nil)
                    
                }
                
            })

        
        }
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }


