import UIKit
import Eureka

class MyFormViewController: FormViewController {
    // Struct for form items tag constants
     struct FormItems {
         // Personal note: These are identifiers.
        
         // Personal
         static let name = "name"
         static let birthDate = "birthDate"
         static let like = "like"
         static let streetAddress = "Street Address"
         static let streetAddress2 = "Street Address 2"
        
        
        
        // Emergency Contacts
        static let eContactName1 = "Name"
        static let eContactPhone1 = "Phone"
        static let eContactRelationship1 = "Relationship"
        
        static let eContactName2 = "Name2"
        static let eContactPhone2 = "Phone2"
        static let eContactRelationship2 = "Relationship2"
        
     }
     
     override func viewDidLoad() {
         //self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         
        
                form = Section("Choose Information To Edit")
                    <<< SegmentedRow<String>("segments"){
                        $0.options = ["Personal", "Contacts", "Medical Conditions"]
                        $0.value = "Personal"
                    }
                    
                    
                    +++ Section(){
                        $0.tag = "personal_s"
                        $0.hidden = "$segments != 'Personal'"
                    }
                    
                    <<< TextRow(FormItems.name) { row in
                        row.title = "Name"
                        row.placeholder = "Your Name"
                    }
                    <<< DateRow(FormItems.birthDate) { row in
                        row.title = "Birthday"
                        //row.placeholder = "DOB"
                    }
                    
                    <<< SegmentedRow<String>(){
                       $0.title = "Gender"
                       $0.options = ["Male", "Female", "Other"]
                     }
       
                   <<< TextRow(FormItems.streetAddress) { row in
                        row.title = "Address Line 1"
                        row.placeholder = "Address Line 1"
                  }
                  
                  <<< TextRow(FormItems.streetAddress2) { row in
                        row.title = "Address Line 2"
                        row.placeholder = "Address Line 2 (Optional)"
                   }

                    
                    +++ Section(){
                        $0.tag = "emergencycontacts_s"
                        $0.hidden = "$segments != 'Contacts'"
                    }
                    
                    <<< TextRow(FormItems.eContactName1) { row in
                        row.title = "Name"
                        row.placeholder = "Emergency Contact Name"
                    }
                    
                    <<< PhoneRow(FormItems.eContactPhone1) { row in
                        row.title = "Phone"
                        row.placeholder = "+(248) 717-0000"
                        row.add(rule: RuleMinLength(minLength: 10))
                        row.add(rule: RuleMaxLength(maxLength: 11))
                    }.cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                    }
                    
                    <<< TextRow(FormItems.eContactRelationship1) { row in
                        row.title = "Relationship"
                        row.placeholder = "Relationship To Patient"
                    }
                    
                    
                    // Get a space right here
                    
                    
            
                    <<< TextRow(FormItems.eContactName2) { row in
                        row.title = "Name"
                        row.placeholder = "Emergency Contact Name"
                    }
                    
                    <<< PhoneRow(FormItems.eContactPhone2) { row in
                        row.title = "Phone"
                        row.placeholder = "+(248) 717-0000"
                        row.add(rule: RuleMinLength(minLength: 10))
                        row.add(rule: RuleMaxLength(maxLength: 11))
                    }.cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                    }
                    
                    <<< TextRow(FormItems.eContactRelationship2) { row in
                        row.title = "Relationship"
                        row.placeholder = "Relationship To Patient"
                    }
                    
                    

                    
                    +++ Section(){
                        $0.tag = "medicalconditions_s"
                        $0.hidden = "$segments != 'Medical Conditions'"
                    }
        
        
       
           
        form +++
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Medical Conditions",
                               footer: "To add a new medical condition, click on the plus.") {
                
                $0.hidden = "$segments != 'Medical Conditions'"
                $0.header?.height = {10}
                $0.tag = "MedicalConditionsMVS"
                
                
                $0.addButtonProvider = { section in
                    return ButtonRow(){
                        $0.title = "Add New Condition"
                    }
                }
                
                $0.multivaluedRowToInsertAt = { index in
                 return NameRow("tag_\(index+1)") {
                  $0.placeholder = "Your option"
                 }
               }
                
            }
        
            
        
            
        
            +++ Section(){ section in
                section.tag = "SaveConditions"
                section.hidden = "$segments != 'Medical Conditions'"
            }
        
            <<< ButtonRow { row in
                row.title = "Save Info"
            }
        
       
                
                    
            
        
        
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }

