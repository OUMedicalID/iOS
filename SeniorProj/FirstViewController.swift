import UIKit
import SwiftUI
import CoreNFC
import NFCReaderWriter
import BiometricAuthentication




var isScanning = false

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        VStack{
            if self.status{
                HomeScreen()
                
            } else {
                VStack{
                    Login()
                }
                 .onAppear{
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                        
                        self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    }
                }
            }
        }
    }
}

struct HomeScreen: View{
    var body: some View{
        VStack{
            
            Image("currency").resizable().frame(width: 300.0, height: 225.0, alignment: .center)
            
            Text("Signed in successfully")
                .font(.title)
                .fontWeight(.bold)
            
            Button(action: {
                
                //try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }) {
                
                Text("Sign out")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Dominant"))
            .cornerRadius(4)
            .padding(.top, 25)
        }
    }
}


struct Login: View{
    
    @State var email = ""
    @State var pass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    
    
    var body: some View{
        VStack(){
            
            
            let images = ["welcome1", "welcome2", "welcome3"]
            Image(images.randomElement()!).resizable().frame(width: 300.0, height: 255.0, alignment: .top)
            
            // No if statements allowed in a VStack, but we can use a ternary operator
            let defaults = UserDefaults.standard
            let name = defaults.string(forKey: "MID_Name")
            //print(name)
            //print(HelperFunctions().decryptData(data: name!))
            
            let name2 = (name != nil ? HelperFunctions().decryptData(data: name!)+"" : "")
            let welcome = "Welcome" + (name2 != "" ? ", "+name2+"!" : "!")
            
            
            Text(welcome)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            
            
            // Begin NFC...
            Button(action: {
                isScanning = true
                self.BeginNFC()
            }) {
                Text("Begin Scan")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                 .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Dominant"))
            .cornerRadius(6)
            .padding(.top, 15)
            .alert(isPresented: $alert){()->Alert in
                return Alert(title: Text("\(self.title)"), message: Text("\(self.error)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
            
            HStack(spacing: 5){
                Text("Your info is securely transmitted").font(.system(.body, design: .rounded))
                            
                           
                            
                            
                        }.padding(.top, 25)
                    }
            
            
        
        .padding(.horizontal, 25)
        
    }
    
    func BeginNFC(){
        isScanning = true
        print("We are here....")
        // The code below is listening for this call and will promptly begin NFC.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil)

        
    }
    
}








class FirstViewController: UIHostingController<Home>,NFCReaderDelegate {
    

    func reader(_ session: NFCReader, didInvalidateWithError error: Error) {
        //
    }
    let readerWriter = NFCReaderWriter.sharedInstance()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: Home());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        
        // Note: may want to switch to viewDidAppear if we end up doing the onboarding as both onboarding and login are intended to
        // pop up when users first open the app.
        // Maybe even delegate this task to a decider class in the future.
        
            let loggedIn = defaults.string(forKey: "isLoggedIn")
            if(loggedIn == nil){
            print("Attempting the show Login....")
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "LoginRegister", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "lr_login") as! LoginPage
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
       
        
        
        // Biometrics Authentication
        let bioAuth = defaults.string(forKey: "bioAuth")
        if(bioAuth != nil){
            if(bioAuth == "on"){
                promptBio()
            }
        }
        
        let password = defaults.string(forKey: "appPassword")
        if(password != nil){
            print("Calling on prompt password)")
            promptPassword()
        }
        
        
        // Password Authentication
        
        
        
        
        HelperFunctions().showAllValues()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)

    }
    

    @objc func showSpinningWheel(_ notification: NSNotification) {
        readerWriter.newWriterSession(with: self, isLegacy: true, invalidateAfterFirstRead: true, alertMessage: "Please go near the Raspberry Pi")
        readerWriter.begin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isScanning = false
        }
     }
    
    
    func reader(_ session: NFCReader, didDetect tags: [NFCNDEFTag]) {
          // here for write test data
        
        DispatchQueue.main.async {
        let email = UserDefaults.standard.string(forKey: "email")
        let key = UserDefaults.standard.string(forKey: "sha512Key")

        var payloadData = Data([0x00])
        let myData = "[[\(email!):\(key!)]]" //Max of 39 characters.
        let urls = [myData]
        payloadData.append(urls[Int.random(in: 0..<urls.count)].data(using: .utf8)!)

        let payload = NFCNDEFPayload.init(
          format: NFCTypeNameFormat.nfcWellKnown,
          type: "T".data(using: .utf8)!,
          identifier: Data.init(count: 0),
          payload: payloadData,
          chunkSize: 0)

        let message = NFCNDEFMessage(records: [payload])

            self.readerWriter.write(message, to: tags.first!) { (error) in
            if let err = error {
                print("ERR:\(err)")
            } else {
                print("write success")
            }
            self.readerWriter.end()
         }
            
    }
  }
    
    
    func promptBio(){
        if BioMetricAuthenticator.canAuthenticate() {

            BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (result) in
                switch result {
                   case .success( _):
                       print("Authentication Successful")
                   case .failure( _):
                       print("Authentication Failed")
                    
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let lockV  = storyboard.instantiateViewController(withIdentifier: "authFail") as! authFailed
                    lockV.isModalInPresentation = true
                    lockV.modalPresentationStyle = .fullScreen
                    self.present(lockV, animated: true, completion: nil)

                    

                    
                   }
               }
            }
        }
    
    
    func promptPassword(){
        DispatchQueue.main.async{
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter Password", message: "Please enter the password that you set.", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "App Password"
            textField.isSecureTextEntry = true
        }

            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Reset App", style: .destructive, handler: { [weak alert] (_) in
                
                _ = alert
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                HelperFunctions().showAlert(title: "App Reset", msg: "App has been reset. Please restart", controller: self)
            }))
            
            
            
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Authenticate", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            let defaults = UserDefaults.standard
            let savedPassword   = defaults.string(forKey: "appPassword")
            let enteredPassword = HelperFunctions().sha512(password: textField!.text!)
            
            if(savedPassword == enteredPassword){
                // We're good.
            }else{
                self.promptPassword()
            }
           
            
        }))
            
            
           

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
        
    }
    
    
    
    
}
