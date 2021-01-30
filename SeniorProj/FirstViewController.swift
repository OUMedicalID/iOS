import UIKit
import SwiftUI
import CoreNFC
import NFCReaderWriter


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
            
            Text("Welcome, John!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            
            
            // Begin NFC...
            Button(action: {
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)

    }
    

    @objc func showSpinningWheel(_ notification: NSNotification) {
        readerWriter.newWriterSession(with: self, isLegacy: true, invalidateAfterFirstRead: true, alertMessage: "Please go near the Raspberry Pi")
        readerWriter.begin()
     }
    
    
    func reader(_ session: NFCReader, didDetect tags: [NFCNDEFTag]) {
          // here for write test data
        
        DispatchQueue.main.async {

        var payloadData = Data([0x02])
        let myData = "X%"+"THE MESSAGE"+"%X";
        let urls = [myData]
        payloadData.append(urls[Int.random(in: 0..<urls.count)].data(using: .utf8)!)

        let payload = NFCNDEFPayload.init(
          format: NFCTypeNameFormat.nfcWellKnown,
          type: "U".data(using: .utf8)!,
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
}
