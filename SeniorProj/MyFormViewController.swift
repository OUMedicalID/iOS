import UIKit
import Eureka

class MyFormViewController: FormViewController {
    // Struct for form items tag constants
     struct FormItems {
         static let name = "name"
         static let birthDate = "birthDate"
         static let like = "like"
         static let streetAddress = "Street Address"
     }
     
     override func viewDidLoad() {
         //self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         
        
         form +++ Section("About You")
            
             <<< TextRow(FormItems.name) { row in
                 row.title = "Name"
                 row.placeholder = "Your Name"
             }
             <<< DateRow(FormItems.birthDate) { row in
                 row.title = "Birthday"
                 //row.placeholder = "DOB"
             }
            
            
            <<< TextRow(FormItems.streetAddress) { row in
                row.title = "Steet Address"
                row.placeholder = "Complete Street Address"
            }
        
         form +++
            
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                                   header: "Multivalued TextField",
                                   footer: ".Insert adds a 'Add Item' (Add New Tag) button row as last cell.") {
                
                    $0.addButtonProvider = { section in
                        return ButtonRow(){
                            $0.title = "Add New Tag"
                        }
                    }
                    $0.multivaluedRowToInsertAt = { index in
                        return NameRow() {
                            $0.placeholder = "Tag Name"
                        }
                    }
                    $0 <<< NameRow() {
                        $0.placeholder = "Tag Name"
                    }
            }
        
                
                

         
         
         
         form +++ Section("Save Information")
             <<< ButtonRow { row in
                 row.title = "Save Info"
                 }.onCellSelection({ [unowned self] (cell, row) in
                      if let nameRow = self.form.rowBy(tag: FormItems.name) as? RowOf<String>,
                         let birthDateRow = self.form.rowBy(tag: FormItems.birthDate) as? RowOf<Date>,
                         let streetAddressRow = self.form.rowBy(tag: FormItems.streetAddress) as? RowOf<String> {
                        
                        // We want to make sure we can print all of our info here.
                        print("Name: " + nameRow.value!)
                        print("Street Address: "+streetAddressRow.value!)
                        
                        if let date = birthDateRow.value {
                           print( "Date: \(date)")
                        } else {
                            //Here display something if no date is available
                        }
                        
                        // create the alert
                        let alert = UIAlertController(title: "Medical Info Saved", message: "Thank you, \(nameRow.value!). Your medical info is saved.", preferredStyle: UIAlertController.Style.alert)

                              // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                       // nameRow.value = "Save"
                       //  nameRow.updateCell()
                         
                        // birthDateRow.value = Date(timeInterval: -900*365*86400, since: Date())
                        // birthDateRow.updateCell()
                         
                        // likeRow.value = true
                       //  likeRow.updateCell()
                       /*
                         row.disabled = .function([FormItems.name]) { form in
                             (form.rowBy(tag: FormItems.name) as? RowOf<String>)?.value == "Save Info"
                         }
                         row.evaluateDisabled()*/
                     }
                 })
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
        
        
     }
    
     
 }

