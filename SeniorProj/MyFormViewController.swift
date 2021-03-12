import UIKit
import Eureka
import MaterialComponents.MaterialSnackbar


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
         static let homePhone = "homePhone"
         static let workPhone = "workPhone"
        
        
         static let marital = "marital"
         static let height = "height"
         static let weight = "weight"
         static let bloodType = "bloodType"
         static let ethnicity = "ethnicity"
         static let primaryInsurance = "primaryInsurance"
         static let policyNumber = "policyNumber"
         static let groupNumberorMPH = "groupNumberorMPH"
         static let accidentInfo = "accidentInfo"
         //static let releasingInfo = "releasingInfo"
         //static let patientConsent = "patientConsent"
         static let illnessHistory = "illnessHistory"
        
        
        
        // Emergency Contacts
        static let eContactName1 = "Name"
        static let eContactPhone1 = "Phone"
        static let eContactRelationship1 = "Relationship"
        
        static let eContactName2 = "Name2"
        static let eContactPhone2 = "Phone2"
        static let eContactRelationship2 = "Relationship2"
        
     }
     
     override func viewDidLoad() {
         self.tableViewStyle = .insetGrouped //We'll uncomment this later.
         super.viewDidLoad()
         let defaults = UserDefaults.standard
        
        
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////Personal Information//////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
        
        
        
                form = Section("Choose Information To Edit")
                    <<< SegmentedRow<String>("segments"){
                        $0.options = ["Personal", "Contacts", "Conditions"]
                        $0.value = "Personal"
                    }
                    
                    
                    +++ Section(header: "Main Personal Information", footer:""){
                        $0.tag = "personal_s"
                        $0.hidden = "$segments != 'Personal'"
                    }
                    
                    <<< TextRow(FormItems.name) { row in
                        row.title = "Name"
                        row.placeholder = "Your Name"
                    }
                    
                    <<< SegmentedRow<String>(){
                       $0.tag = "gender"
                       $0.title = "Gender"
                       $0.options = ["Male", "Female", "Other"]
                     }
                    
                    
                    <<< DateRow(FormItems.birthDate) { row in
                        row.title = "Date Of Birth"
                        row.noValueDisplayText = "Select DOB"
                        //row.placeholder = "DOB"
                    }.cellUpdate({ (cell, row) in
                        // Make the text black like everything else rather than gray.
                        
                        cell.detailTextLabel?.textColor = UIColor.black
                    })
                    
                    
       
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
                  }.cellUpdate({ (cell, row) in
                    // Make the text black like everything else rather than gray.
                    cell.detailTextLabel?.textColor = UIColor.black
                  })
                    
                    <<< ZipCodeRow(FormItems.zip) { row in
                        row.title = "ZIP Code"
                        row.placeholder = "5-Digit ZIP"
                  }
                    
                    <<< PhoneRow(FormItems.homePhone) {
                        $0.title = "Home Phone"
                        $0.placeholder = "Home Phone Number"
                    }
                    
                    <<< PhoneRow(FormItems.workPhone) {
                        $0.title = "Work Phone"
                        $0.placeholder = "Work Phone Number"
                    }
                
                    
                    
                    +++ Section(header: "Other Personal Information", footer: "M.P.H = Main Policy Holder"){
                        $0.tag = "personal_s2"
                        $0.hidden = "$segments != 'Personal'"
                        
                    }
                  
                    
                    <<< ActionSheetRow<String>() {
                        $0.tag = FormItems.marital
                        $0.title = "Marital Status"
                        $0.selectorTitle = "What's your martial status?"
                        $0.options = ["Single", "Married", "Divorced", "Widowed"]
                        $0.noValueDisplayText = "Select Status"
                        }.onPresent { from, to in
                         to.popoverPresentationController?.permittedArrowDirections = .up
                        }.cellUpdate({ (cell, row) in
                            // Make the text black like everything else rather than gray.
                            cell.detailTextLabel?.textColor = UIColor.black
                        })
                    
                    /*
                     <<< DoublePickerInlineRow<String, String>() {
                        $0.tag = FormItems.height
                        $0.title = "Height"
                        $0.firstOptions = { return ["2'", "3'", "4'", "5'","6'", "7'", "8'"]}
                        $0.secondOptions = { _ in return ["1\"", "2\"","3\""]}
                        $0.noValueDisplayText = "Height"
                    }
                    */
                    
                    
                    <<< TextRow(FormItems.weight) { row in
                        row.title = "Weight"
                        row.placeholder = "Weight"
                    }
                    
                    
                    <<< TextRow(FormItems.height) { row in
                        row.title = "Height"
                        row.placeholder = "Height"
                    }
                   
                    
                    
                    
                    <<< ActionSheetRow<String>() {
                        $0.tag = FormItems.bloodType
                        $0.title = "Blood Type"
                        $0.selectorTitle = "What's your blood type?"
                        $0.options = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                        $0.noValueDisplayText = "Select Status"
                        }.onPresent { from, to in
                         to.popoverPresentationController?.permittedArrowDirections = .up
                        }.cellUpdate({ (cell, row) in
                            // Make the text black like everything else rather than gray.
                            cell.detailTextLabel?.textColor = UIColor.black
                        })
                    
                    <<< ActionSheetRow<String>() {
                        $0.tag = FormItems.ethnicity
                        $0.title = "Ethnicity"
                        $0.selectorTitle = "What's your ethnicity?"
                        $0.options = ["American Indian or Alaskan Native", "Asian", "Black or African American", "Hispanic or Latino", "Native Hawaiian or other Pacific Islander", "White", "Two or more races", "Other"]
                        $0.noValueDisplayText = "Select Status"
                        }.onPresent { from, to in
                         to.popoverPresentationController?.permittedArrowDirections = .up
                        }.cellUpdate({ (cell, row) in
                            // Make the text black like everything else rather than gray.
                            cell.detailTextLabel?.textColor = UIColor.black
                        })
                    
                    <<< TextRow(FormItems.primaryInsurance) { row in
                        row.title = "Primary Insurance"
                        row.placeholder = "Primary Insurance"
                    }
                    
                    <<< TextRow(FormItems.policyNumber) { row in
                        row.title = "Policy Number"
                        row.placeholder = "Policy Number"
                    }
                    
                    <<< TextRow(FormItems.groupNumberorMPH) { row in
                        row.title = "Group # / M.P.H"
                        row.placeholder = "Group # / M.P.H"
                    }
                    
                    
                    
                   
                    
                    
                    
                    
                    
                    +++ Section(){ section in
                        section.tag = "SavePersonalInformation"
                        section.hidden = "$segments != 'Personal'"
                    }
                
                    
                    
                    
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////Save Personal Information//////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    <<< ButtonRow { row in
                        row.title = "Save Personal Information"
                    }.onCellSelection({ [unowned self] (cell, row) in
                        print(self)
                        print("Save Personal Info clicked!")
                        
                        
                        if let homeP = self.form.rowBy(tag: FormItems.homePhone) as? RowOf<String>{
                            if(homeP.value == nil){
                                return
                            }
                            print("Saving homeP")
                            defaults.set(HelperFunctions().encryptData(data: homeP.value!), forKey: "MID_HomePhone")
                        }
                        
                            
                        if let workP = self.form.rowBy(tag: FormItems.workPhone) as? RowOf<String>{
                            if(workP.value == nil){
                                return
                            }
                            print("Saving workP")
                            defaults.set(HelperFunctions().encryptData(data: workP.value!), forKey: "MID_WorkPhone")
                        }
                        
                        
                        
                        
                        let nameV  = self.form.rowBy(tag: FormItems.name) as? RowOf<String>
                        let birthdayV = self.form.rowBy(tag: FormItems.birthDate) as? RowOf<Date>
                        let genderV = self.form.rowBy(tag: "gender") as? RowOf<String>
                        let addressLine1V = self.form.rowBy(tag: FormItems.streetAddress) as? RowOf<String>
                        let cityV = self.form.rowBy(tag: FormItems.city) as? RowOf<String>
                        let stateV = self.form.rowBy(tag: FormItems.state) as? RowOf<String>
                        let zipV = self.form.rowBy(tag: FormItems.zip) as? RowOf<String>
                       
                        let maritalV = self.form.rowBy(tag: FormItems.marital) as? RowOf<String>
                        let heightV = self.form.rowBy(tag: FormItems.height) as? RowOf<String>
                        let weightV = self.form.rowBy(tag: FormItems.weight) as? RowOf<String>
                        let bloodTypeV = self.form.rowBy(tag: FormItems.bloodType) as? RowOf<String>
                        let ethnicityV = self.form.rowBy(tag: FormItems.ethnicity) as? RowOf<String>
                        let primaryInsuranceV = self.form.rowBy(tag: FormItems.primaryInsurance) as? RowOf<String>
                        let policyNumV = self.form.rowBy(tag: FormItems.policyNumber) as? RowOf<String>
                        let GroupMPHV = self.form.rowBy(tag: FormItems.groupNumberorMPH) as? RowOf<String>
                        
                        
                        
                        
                        if let name = nameV, let bday = birthdayV, let gender = genderV, let addr1 = addressLine1V, let city = cityV, let state = stateV, let zip = zipV, let marital = maritalV, let weight = weightV, let bloodType = bloodTypeV, let ethnicity = ethnicityV, let primaryInsurance = primaryInsuranceV, let height = heightV, let policyNum = policyNumV, let GroupMPH = GroupMPHV{
                            
                            print("We have passed this stage")
                            if(name.value == nil || bday.value == nil || addr1.value == nil || city.value == nil || state.value == nil || state.value == "Select State" || zip.value == nil || marital.value == nil || marital.value == "Select Status" || weight.value == nil || bloodType.value == nil || bloodType.value == "Select Status" || ethnicity.value == nil || ethnicity.value == "Select Status" || primaryInsurance.value == nil /*|| accidentInfo.value == nil || illnessHistory.value == nil|| height.value == nil*/ || gender.value == nil){
                                
                                HelperFunctions().showAlert(title: "Error", msg: "Please fill out everything", controller: self)
                                return
                            }
                            
                            
                            let df = DateFormatter()
                            df.dateFormat = "MM/dd/yyyy"
                            let birthday = HelperFunctions().encryptData(data:df.string(from: bday.value!))
                            
                            
                            defaults.set(HelperFunctions().encryptData(data: name.value!), forKey: "MID_Name")
                            defaults.set(birthday, forKey: "MID_Birthday")
                            defaults.set(HelperFunctions().encryptData(data: gender.value!), forKey: "MID_Gender")
                            defaults.set(HelperFunctions().encryptData(data: addr1.value!), forKey: "MID_Address1")
                            defaults.set(HelperFunctions().encryptData(data: city.value!), forKey: "MID_City")
                            defaults.set(HelperFunctions().encryptData(data: state.value!), forKey: "MID_State")
                            defaults.set(HelperFunctions().encryptData(data: zip.value!), forKey: "MID_Zip")
                           
                            defaults.set(HelperFunctions().encryptData(data: marital.value!), forKey: "MID_MaritalStatus")
                            defaults.set(HelperFunctions().encryptData(data: height.value!), forKey: "MID_Height")
                            defaults.set(HelperFunctions().encryptData(data: weight.value!), forKey: "MID_Weight")
                            defaults.set(HelperFunctions().encryptData(data: bloodType.value!), forKey: "MID_BloodType")
                            defaults.set(HelperFunctions().encryptData(data: ethnicity.value!), forKey: "MID_Ethnicity")
                            defaults.set(HelperFunctions().encryptData(data: primaryInsurance.value!), forKey: "MID_PrimaryInsurance")
                            defaults.set(HelperFunctions().encryptData(data: policyNum.value!), forKey: "MID_PrimaryInsuranceNumber")
                            defaults.set(HelperFunctions().encryptData(data: GroupMPH.value!), forKey: "MID_PrimaryInsuranceGroupNumberOrMainPH")
                            
                            
                            let message = MDCSnackbarMessage()
                            message.text = "Information has been saved."
                            message.duration = 2
                            MDCSnackbarManager.default.show(message)
                            
                            
                            
                        if let address2 = self.form.rowBy(tag: FormItems.streetAddress2) as? RowOf<String>{
                            if(address2.value == nil){
                                return
                            }
                            defaults.set(HelperFunctions().encryptData(data: address2.value!), forKey: "MID_Address2")
                        }
                            
                        
                            
                            
                            
                           
                            
                     }
                        
                       
                        
                    })
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////Emergency Contact Section//////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    

                    
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
                    
                    
                    
                    
                    
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////Save Emergency Contact Information//////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
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
                            
                            
                            let EContact1 = [name.value!, phone.value!, rel.value!]
                            let JSON = HelperFunctions().json(from:EContact1 as Any)
                            print("The JSON: " + JSON!)
                            let hexJ = JSON!.toHexEncodedString()
                            
                            
                            defaults.set(HelperFunctions().encryptData(data: hexJ), forKey: "MID_EContact1")
                            
                           
                            let message = MDCSnackbarMessage()
                            message.text = "Contacts have been saved."
                            message.duration = 2
                            MDCSnackbarManager.default.show(message)
                            
                            
                            
                        } // End big let
                        
                        // SAVE OPTIONAL ECONTACT
                        
                        let name2  = self.form.rowBy(tag: FormItems.eContactName2) as? RowOf<String>
                        let phone2 = self.form.rowBy(tag: FormItems.eContactPhone2) as? RowOf<String>
                        let relationship2 = self.form.rowBy(tag: FormItems.eContactRelationship2) as? RowOf<String>
                        
                        
                        if let optName = name2, let optPhone = phone2, let optRel = relationship2{
                        
                            
                            if(optName.value == nil || optPhone.value == nil || optRel.value == nil){
                                return
                            }
                        
                            
                            
                            
                            let EContact2 = [optName.value!, optPhone.value!, optRel.value!]
                            let JSON = HelperFunctions().json(from:EContact2 as Any)
                            let hexJ = JSON!.toHexEncodedString()
                            
                            
                            defaults.set(HelperFunctions().encryptData(data: hexJ), forKey: "MID_EContact2")
                                    
        
                        
                        }
                        
                        
                        // Prepare to save.
                    
                        
                        
                    })
                    
                    
                    
    
                    
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////Medical Conditions//////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    
                    
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
                let medicalConditions = defaults.stringArray(forKey: "MID_Conditions") ?? [String]()
                
                // Loop through all saved conditions and put them back.
                for condition in medicalConditions {
                    $0 <<< NameRow() {
                        $0.value = HelperFunctions().decryptData(data: condition)
                    }
                }
                
                
                
            }
            
            
            
        form +++
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
             header: "Injury Information",
             footer: "To add new injury information, click on the plus.") {
                
                $0.hidden = "$segments != 'Conditions'"
                $0.header?.height = {40}
                $0.tag = "InjuryMVS"
                
                
                $0.addButtonProvider = { section in
                    return ButtonRow(){
                        $0.title = "Add New Injury"
                    }
                }
                
                $0.multivaluedRowToInsertAt = { index in
                 return NameRow("injury_tag_\(index+1)") {
                  $0.placeholder = "Your option"
                 }
               }
                
                
                // Restore Injuries
                let injuries = defaults.stringArray(forKey: "MID_Injuries") ?? [String]()
                
                // Loop through all saved conditions and put them back.
                for condition in injuries {
                    $0 <<< NameRow() {
                        $0.value = HelperFunctions().decryptData(data: condition)
                    }
                }
                
                
                
            }
            
            
            
            
            
        
            
            
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////Save Conditions //////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
        
            +++ Section(){ section in
                section.tag = "SaveConditions"
                section.hidden = "$segments != 'Conditions'"
            }
        
            <<< ButtonRow { row in
                row.title = "Save Conditions"
            }.onCellSelection({ [unowned self] (cell, row) in
                
                print(self)
                print("Button was clicked!")
                
                let listofValues: [String]? = (form.sectionBy(tag: "MedicalConditionsMVS")?.compactMap {($0 as? NameRow)?.value })
                let medicalConditionValues = listofValues!.compactMap { HelperFunctions().encryptData(data: $0) }
                defaults.set(medicalConditionValues, forKey: "MID_Conditions")
                
                
                let injuryValues: [String]? = (form.sectionBy(tag: "InjuryMVS")?.compactMap { ($0 as? NameRow)?.value })
                let InjuriesMVS = injuryValues!.compactMap { HelperFunctions().encryptData(data: $0) }
                defaults.set(InjuriesMVS, forKey: "MID_Injuries")
                
                
                let message = MDCSnackbarMessage()
                message.text = "Conditions has been saved."
                message.duration = 2
                MDCSnackbarManager.default.show(message)

                
            })
        
       
        
        
        
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////ALL Data Restoration//////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        // Restore Personal
        let name = defaults.string(forKey: "MID_Name")
        let birthday = defaults.string(forKey: "MID_Birthday")
        let gender = defaults.string(forKey: "MID_Gender")
        let address1 = defaults.string(forKey: "MID_Address1")
        let address2 = defaults.string(forKey: "MID_Address2")
        let city = defaults.string(forKey: "MID_City")
        let state = defaults.string(forKey: "MID_State")
        let zip = defaults.string(forKey: "MID_Zip")
        let homePhone = defaults.string(forKey: "MID_HomePhone")
        let workPhone = defaults.string(forKey: "MID_WorkPhone")
        
        
        let marital = defaults.string(forKey: "MID_MaritalStatus")
        let height = defaults.string(forKey: "MID_Height")
        let weight = defaults.string(forKey: "MID_Weight")
        let bloodType = defaults.string(forKey: "MID_BloodType")
        let ethnicity = defaults.string(forKey: "MID_Ethnicity")
        let primaryInsurance = defaults.string(forKey: "MID_PrimaryInsurance")
        let policyNum = defaults.string(forKey: "MID_PrimaryInsuranceNumber")
        let groupMPH = defaults.string(forKey: "MID_PrimaryInsuranceGroupNumberOrMainPH")
        
        
        
        if(name != nil){
            print("name is not nil")
            self.form.rowBy(tag: FormItems.name)?.baseValue = HelperFunctions().decryptData(data: name!)
        }
        
        if(birthday != nil){
            let decryptedbday = HelperFunctions().decryptData(data: birthday!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = dateFormatter.date(from:decryptedbday)
            self.form.rowBy(tag: FormItems.birthDate)?.baseValue = date
        }
        
        if(gender != nil){
            self.form.rowBy(tag: "gender")?.baseValue = HelperFunctions().decryptData(data: gender!)
        }
        if(address1 != nil){
            self.form.rowBy(tag: FormItems.streetAddress)?.baseValue = HelperFunctions().decryptData(data: address1!)
        }
        if(address2 != nil){
            self.form.rowBy(tag: FormItems.streetAddress2)?.baseValue = HelperFunctions().decryptData(data: address2!)
        }
        if(city != nil){
            self.form.rowBy(tag: FormItems.city)?.baseValue = HelperFunctions().decryptData(data: city!)
        }
        
        if(state != nil){
            self.form.rowBy(tag: FormItems.state)?.baseValue = HelperFunctions().decryptData(data: state!)
        }
        
        if(zip != nil){
            self.form.rowBy(tag: FormItems.zip)?.baseValue = HelperFunctions().decryptData(data: zip!)
        }
        
        if(homePhone != nil){
            self.form.rowBy(tag: FormItems.homePhone)?.baseValue = HelperFunctions().decryptData(data: homePhone!)
        }
        
        if(workPhone != nil){
            self.form.rowBy(tag: FormItems.workPhone)?.baseValue = HelperFunctions().decryptData(data: workPhone!)
        }
        
        
        
        if(marital != nil){
            self.form.rowBy(tag: FormItems.marital)?.baseValue = HelperFunctions().decryptData(data: marital!)
        }
        
        if(height != nil){
            self.form.rowBy(tag: FormItems.height)?.baseValue = HelperFunctions().decryptData(data: height!)
        }
                
        if(weight != nil){
            self.form.rowBy(tag: FormItems.weight)?.baseValue = HelperFunctions().decryptData(data: weight!)
        }
                
        if(bloodType != nil){
            self.form.rowBy(tag: "bloodType")?.baseValue = HelperFunctions().decryptData(data: bloodType!)
        }
                
        if(ethnicity != nil){
            self.form.rowBy(tag: "ethnicity")?.baseValue = HelperFunctions().decryptData(data: ethnicity!)
        }
                
        if(primaryInsurance != nil){
            self.form.rowBy(tag: FormItems.primaryInsurance)?.baseValue = HelperFunctions().decryptData(data: primaryInsurance!)
        }
                
      
        
        if(policyNum != nil){
            self.form.rowBy(tag: FormItems.policyNumber)?.baseValue = HelperFunctions().decryptData(data: policyNum!)
        }
                
        if(groupMPH != nil){
            self.form.rowBy(tag: FormItems.groupNumberorMPH)?.baseValue = HelperFunctions().decryptData(data: groupMPH!)
        }
        
        
        
        
                
        // Restore Contactss
        let EContact1 = defaults.string(forKey: "MID_EContact1")
        if(EContact1 != nil){
            let JSON = HelperFunctions().decryptData(data: EContact1!).hexToString()
            print(JSON)
            let dict = JSON.toJSON() as! [String]
            
            let name = dict[0]
            let phone = dict[1]
            let relationship = dict[2]
            
            
            self.form.rowBy(tag: FormItems.eContactName1)?.baseValue = name
            self.form.rowBy(tag: FormItems.eContactPhone1)?.baseValue = phone
            self.form.rowBy(tag: FormItems.eContactRelationship1)?.baseValue = relationship
        }
        
        
        let EContact2 = defaults.string(forKey: "MID_EContact2")
        if(EContact2 != nil){
            
            let JSON = HelperFunctions().decryptData(data: EContact2!).hexToString()
            let dict = JSON.toJSON() as! [String]
            
            let name = dict[0]
            let phone = dict[1]
            let relationship = dict[2]
            
            self.form.rowBy(tag: FormItems.eContactName2)?.baseValue = name
            self.form.rowBy(tag: FormItems.eContactPhone2)?.baseValue = phone
            self.form.rowBy(tag: FormItems.eContactRelationship2)?.baseValue = relationship
        
        }
        
        

        
        // Deleting the line below gets rid of icons (We don't want this)
        tableView.isEditing = true
     }
    
     
 }



extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

extension String {
    func toHexEncodedString(uppercase: Bool = true, prefix: String = "", separator: String = "") -> String {
        return unicodeScalars.map { prefix + .init($0.value, radix: 16, uppercase: uppercase) } .joined(separator: separator)
    }
}


extension String {
    
    func hexToString()->String{
        
        var finalString = ""
        let chars = Array(self)
        
        for count in stride(from: 0, to: chars.count - 1, by: 2){
            let firstDigit =  Int.init("\(chars[count])", radix: 16) ?? 0
            let lastDigit = Int.init("\(chars[count + 1])", radix: 16) ?? 0
            let decimal = firstDigit * 16 + lastDigit
            let decimalString = String(format: "%c", decimal) as String
            finalString.append(Character.init(decimalString))
        }
        return finalString
        
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .init(rawValue: 0))
    }
}
