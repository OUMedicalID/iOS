import UIKit
import Eureka
import BiometricAuthentication
import MaterialComponents.MaterialSnackbar

class Settings: FormViewController {
     
    
    
    
     override func viewDidLoad() {
         self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        
        
        
        
        
        
         form +++ Section(header: "Biometric Authentication", footer: "Require TouchID or FaceID to open the app. Note that you must have TouchID or FaceID setup.")
            
            <<< SwitchRow("mySwitch") {
                $0.title = "Enable Biometric Authentication"
                $0.value = false
            }.cellSetup() { cell, row in
                // Note: Swift doesn't use standard RGB values. Must divide all values by 255.
                cell.switchControl?.onTintColor = UIColor(red: 31/255, green: 133/255, blue: 222/255, alpha: 1.0)
            }.onChange { row in
               (row.value ?? false) ? defaults.set("on", forKey: "bioAuth") : defaults.set("off", forKey: "bioAuth")

                if(row.value!){
                    print("Clearing password option")
                    defaults.set(nil, forKey: "appPassword")
                }
                
                let status = (row.value ?? false) ? "on" : "off"
                let message = MDCSnackbarMessage()
                message.text = "Biometric Authentication is now "+status
                message.duration = 2
                MDCSnackbarManager.default.show(message)
                
                
            }

            
        form +++ Section(header: "Application Configuration",  footer: "Note that using password authentication disables biometric authentication and vice versa.")
            
            <<< LabelRow () {
              $0.title = "Password Authentication"
              //$0.value = ""
            }.onCellSelection { cell, row in
                print("Clicked")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsPassword") as! SettingsPassword
                self.present(vc, animated: true, completion: nil)
                
            }.cellSetup() { cell, row in
                cell.accessoryType = .disclosureIndicator
            }
            
            <<< LabelRow () {
              $0.title = "Clear Application Data"
              //$0.value = ""
            }.onCellSelection { cell, row in
                let refreshAlert = UIAlertController(title: "Clear Application Data",
                message: "All data will be lost. Please confirm only if you are sure you want to delete all data.", preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default,
                handler: { (action: UIAlertAction!) in
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                }))

                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                }))

                self.present(refreshAlert, animated: true, completion: nil)
                
                
            }.cellSetup() { cell, row in
                cell.accessoryType = .disclosureIndicator
            }
            
            
        form +++ Section("Application Information")
           
            <<< LabelRow () {
              $0.title = "About The App"
            }.cellSetup() { cell, row in
                cell.accessoryType = .disclosureIndicator
            }.onCellSelection{cell, row in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "AboutApp") as! AboutApp
                self.present(vc, animated: true, completion: nil)
            }
            
            <<< LabelRow () {
              $0.title = "Credits"
            }.cellSetup() { cell, row in
                cell.accessoryType = .disclosureIndicator
            }.onCellSelection { cell, row in
                print("Clicked")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "credits") as! Credits
                self.present(vc, animated: true, completion: nil)
                
            }
            
            <<< LabelRow () {
              $0.title = "Application Version"
              $0.value = appVersion
            }
            

        
        
        
        // Restorations
        let bioAuth = defaults.string(forKey: "bioAuth")
        if(bioAuth != nil){
            if(bioAuth == "on"){
                self.form.rowBy(tag: "mySwitch")?.value = true
            }
        }
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }


