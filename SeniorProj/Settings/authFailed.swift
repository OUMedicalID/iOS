import UIKit
import SwiftUI
import CoreNFC
import NFCReaderWriter
import BiometricAuthentication






struct ContentView2: View {
    var body: some View {
        Home2()
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

struct Home2: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        VStack{
            if self.status{
                HomeScreen2()
                
            } else {
                VStack{
                    Login2()
                }
                 .onAppear{
                    
                }
            }
        }
    }
}

struct HomeScreen2: View{
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


struct Login2: View{
    
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
            
            
            let images = ["authentication"]
            Image(images.randomElement()!).resizable().frame(width: 300.0, height: 255.0, alignment: .top)
            
          
            
            let msg = "Authentication Failed"
            
            
            Text(msg)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
                .foregroundColor(Color.red)
            
            
            
            // Begin NFC...
            Button(action: {
                print("Prompting for reset")
                NotificationCenter.default.post(name: NSNotification.Name("reset"), object: nil)
            }) {
                Text("Reset Application")
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
                Text("We could not authenticate you. Please restart the app to try again, or click the button above to reset all data.").font(.system(.body, design: .rounded))
                            
                           
                            
                            
                        }.padding(.top, 25)
                    }
            
            
        
        .padding(.horizontal, 25)
        
    }
    
   
    
}








class authFailed: UIHostingController<Home2>{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: Home2());
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.promptReset(_:)), name: NSNotification.Name(rawValue: "reset"), object: nil)
        HelperFunctions().showAllValues()
        
       
        
    }
    
    @objc func promptReset(_ notification: NSNotification) {
    
        let refreshAlert = UIAlertController(title: "Clear Application Data",
        message: "All data will be lost. Please confirm only if you are sure you want to delete all data.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default,
        handler: { (action: UIAlertAction!) in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
            HelperFunctions().showAlert(title: "App Reset", msg: "Please restart.", controller: self)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
        handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
    }

}
