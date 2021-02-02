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
         static let city = "city"
         static let state = "state"
         static let zip = "zip"
         static let marital = "marital"
         static let height = "height"
        
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
         let defaults = UserDefaults.standard
        
        
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////Personal Information///////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
        
        
        
                form = Section("Choose Information To Edit")
                    <<< SegmentedRow<String>("segments"){
                        $0.options = ["Personal", "Contacts", "Conditions"]
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
                       $0.tag = "gender"
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
                    
                  <<< TextRow(FormItems.city) { row in
                        row.title = "City"
                        row.placeholder = "City"
                  }
                    
                  <<< PickerInputRow<String>("State"){
                        $0.tag = FormItems.state
                        $0.title = "State"
                        $0.options = HelperFunctions().states
                        $0.noValueDisplayText = "Select State" //If we want to set a default value.
                  }
                    
                    <<< ZipCodeRow(FormItems.zip) { row in
                        row.title = "ZIP Code"
                        row.placeholder = "5-Digit ZIP"
                  }
                
                    
                  
                    
                    <<< ActionSheetRow<String>() {
                        $0.tag = FormItems.marital
                        $0.title = "Marital Status"
                        $0.selectorTitle = "What's your martial status?"
                        $0.options = ["Single", "Married", "Divorced", "Widowed"]
                        $0.noValueDisplayText = "Select Status"
                        }.onPresent { from, to in
                         to.popoverPresentationController?.permittedArrowDirections = .up
                        }
                    /*
                     <<< DoublePickerInlineRow<String, String>() {
                        $0.tag = FormItems.height
                        $0.title = "Height"
                        $0.firstOptions = { return ["2'", "3'", "4'", "5'","6'", "7'", "8'"]}
                        $0.secondOptions = { _ in return ["1\"", "2\"","3\""]}
                        $0.noValueDisplayText = "Height"
                    }
                    */
                    
                    
                    
                    +++ Section(){ section in
                        section.tag = "SavePersonalInformation"
                        section.hidden = "$segments != 'Personal'"
                    }
                
                    
                    
                    
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////////Save Personal Info//////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    <<< ButtonRow { row in
                        row.title = "Save Personal Information"
                    }.onCellSelection({ [unowned self] (cell, row) in
                        print(self)
                        print("Save Personal Info clicked!")
                        
                        let nameV  = self.form.rowBy(tag: FormItems.name) as? RowOf<String>
                        let birthdayV = self.form.rowBy(tag: FormItems.birthDate) as? RowOf<Date>
                        let genderV = self.form.rowBy(tag: "gender") as? RowOf<String>
                        let addressLine1V = self.form.rowBy(tag: FormItems.streetAddress) as? RowOf<String>
                        let cityV = self.form.rowBy(tag: FormItems.city) as? RowOf<String>
                        let stateV = self.form.rowBy(tag: FormItems.state) as? RowOf<String>
                        let zipV = self.form.rowBy(tag: FormItems.zip) as? RowOf<String>
                        let maritalV = self.form.rowBy(tag: FormItems.marital) as? RowOf<String>
                        let heightV = self.form.rowBy(tag: FormItems.height) as? RowOf<String>
                        
                        
                        
                        if let name = nameV, let bday = birthdayV, let gender = genderV, let addr1 = addressLine1V, let city = cityV, let state = stateV, let zip = zipV, let marital = maritalV/*, let height = heightV*/{
                            
                            print("We have passed this stage")
                            if(name.value == nil || bday.value == nil || addr1.value == nil || city.value == nil || state.value == nil || state.value == "Select State" || zip.value == nil || marital.value == nil /*|| height.value == nil*/){
                                
                                HelperFunctions().showAlert(title: "Error", msg: "Please fill out everything", controller: self)
                                return
                            }
                            
                           
                            
                            defaults.set(name.value, forKey: "name")
                            defaults.set(bday.value, forKey: "birthday")
                            defaults.set(gender.value, forKey: "gender")
                            defaults.set(addr1.value, forKey: "address1")
                            defaults.set(city.value, forKey: "city")
                            defaults.set(state.value, forKey: "state")
                            defaults.set(zip.value, forKey: "zip")
                            defaults.set(marital.value, forKey: "marital")
                            //defaults.set(height.value, forKey: "height")
                            
                            if let addressLine2V = self.form.rowBy(tag: FormItems.streetAddress2) as? RowOf<String>{
                                defaults.set(addressLine2V.value, forKey: "address2")
                            }
                            
                        }
                        
                    })
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////Emergency Contact Section///////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    
                    

                    
                    +++ Section(header: "Emergency Contact 1", footer: ""){
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
                    
                  
                    +++ Section(header: "Emergency Contact 2 (Optional)", footer: ""){
                       
                        $0.tag = "emergencycontacts_s"
                        $0.hidden = "$segments != 'Contacts'"
                    }
                    
                    
            
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
                    
                    
                    

                    +++ Section(){ section in
                        section.tag = "SaveContacts"
                        section.hidden = "$segments != 'Contacts'"
                    }
                    
                    
                    
                    
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////Save Emergency Contacts///////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                    <<< ButtonRow { row in
                        row.title = "Save Contacts"
                    }.onCellSelection({ [unowned self] (cell, row) in
                        print(self)
                        //print("We are trying to save contacts")
                        
                        let name1  = self.form.rowBy(tag: FormItems.eContactName1) as? RowOf<String>
                        let phone1 = self.form.rowBy(tag: FormItems.eContactPhone1) as? RowOf<String>
                        let relationship1 = self.form.rowBy(tag: FormItems.eContactRelationship1) as? RowOf<String>
                        
                        
                        if let name = name1, let phone = phone1, let rel = relationship1{
                            
                            if(name.value == nil || phone.value == nil || rel.value == nil){
                                HelperFunctions().showAlert(title: "Error", msg: "Fill out everything", controller: self)
                                return
                            }
                            
                            if(phone.value!.count < 10 || phone.value!.count > 11){
                                HelperFunctions().showAlert(title: "Error", msg: "Invalid Phone", controller: self)
                            }
                            
                            
                            let EContact1 = ["name": name.value!, "phone": phone.value!, "relationship": rel.value!]
                            defaults.set(EContact1, forKey: "EContact1")
                            
                        }
                        
                    })
                    
                    
    
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////////Medical Conditions/////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    
                    
        +++ Section(){
                $0.tag = "medicalconditions_s"
                $0.hidden = "$segments != 'Conditions'"
        }
        
        
       
           
        form +++
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Medical Conditions",
                               footer: "To add a new medical condition, click on the plus.") {
                
                $0.hidden = "$segments != 'Conditions'"
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
                
                
                // Restore Medical Conditions
                let medicalConditions = defaults.stringArray(forKey: "medicalConditions") ?? [String]()
                
                // Loop through all saved conditions and put them back.
                for condition in medicalConditions {
                    $0 <<< NameRow() {
                        $0.value = condition
                    }
                }
                
                
                
            }
        
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////Save Conditions////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
        
            +++ Section(){ section in
                section.tag = "SaveConditions"
                section.hidden = "$segments != 'Conditions'"
            }
        
            <<< ButtonRow { row in
                row.title = "Save Conditions"
            }.onCellSelection({ [unowned self] (cell, row) in
                
                print(self)
                print("Button was clicked!")
                let listofValues: [String]? = (form.sectionBy(tag: "MedicalConditionsMVS")?.compactMap { ($0 as? NameRow)?.value })
                
                
                print("We are going to save medical conditions")
                let medicalConditionValues = listofValues!.compactMap { $0 }
                print(medicalConditionValues)
                
                defaults.set(medicalConditionValues, forKey: "medicalConditions")
                print("Medical Conditions Saved")
                
            })
        
       
        
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////ALL Data Restoration////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        // Restore Personal
        let name = defaults.string(forKey: "name")
        let birthday = defaults.object(forKey: "birthday")
        let gender = defaults.string(forKey: "gender")
        let address1 = defaults.string(forKey: "address1")
        let address2 = defaults.string(forKey: "address2")
        let city = defaults.string(forKey: "city")
        let state = defaults.string(forKey: "state")
        let zip = defaults.string(forKey: "zip")
        let marital = defaults.string(forKey: "marital")
        let height = defaults.string(forKey: "height")
        
        
        if(name != nil){
            print("name is not nil")
            self.form.rowBy(tag: FormItems.name)?.baseValue = name
        }
        if(birthday != nil){
            let date = birthday as! Date
            self.form.rowBy(tag: FormItems.birthDate)?.baseValue = date
        }
        if(gender != nil){
            self.form.rowBy(tag: "gender")?.baseValue = gender
        }
        if(address1 != nil){
            self.form.rowBy(tag: FormItems.streetAddress)?.baseValue = address1
        }
        if(address2 != nil){
            self.form.rowBy(tag: FormItems.streetAddress2)?.baseValue = address2
        }
        if(city != nil){
            self.form.rowBy(tag: FormItems.city)?.baseValue = city
        }
        
        if(state != nil){
            self.form.rowBy(tag: FormItems.state)?.baseValue = state
        }
        
        if(zip != nil){
            self.form.rowBy(tag: FormItems.zip)?.baseValue = zip
        }
        
        if(marital != nil){
            self.form.rowBy(tag: FormItems.marital)?.baseValue = marital
        }
        
        /*
        if(height != nil){
            self.form.rowBy(tag: FormItems.height)?.baseValue = height
        }*/
        
        
                
        // Restore Contactss
        let EContact1 = defaults.dictionary(forKey: "EContact1")
        if(EContact1 != nil){
            self.form.rowBy(tag: FormItems.eContactName1)?.baseValue = EContact1!["name"] as! String
            self.form.rowBy(tag: FormItems.eContactPhone1)?.baseValue = EContact1!["phone"] as! String
            self.form.rowBy(tag: FormItems.eContactRelationship1)?.baseValue = EContact1!["relationship"] as! String
        }
        
        
        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }

