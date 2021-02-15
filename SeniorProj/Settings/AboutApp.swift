import UIKit
import SwiftUI
import CoreNFC
import NFCReaderWriter
import BiometricAuthentication






struct ContentView3: View {
    var body: some View {
        Home3()
    }
}

struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}

struct Home3: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        VStack{
            if self.status{
                HomeScreen3()
                
            } else {
                VStack{
                    Login3()
                }
                 .onAppear{
                    
                }
            }
        }
    }
}

struct HomeScreen3: View{
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


struct Login3: View{
    
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
            
            
            let images = ["about"]
            Image(images.randomElement()!).resizable().frame(width: 300.0, height: 255.0, alignment: .top)
            
          
            
            let msg = "About The App"
            
            
            Text(msg)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
                .foregroundColor(Color(red: 31/255, green: 133/255, blue: 222/255, opacity: 1.0))
            
            
          
            
            HStack(spacing: 5){
                Text("Medical ID is an app designed to make visits to medical centers as easy as possible.\n\nUsing NFC technology, patients can securely transfer encrypted information to medical organizations and never have to worry about constantly filling out the same basic information.").font(.system(.body, design: .rounded))
                            
                           
                            
                            
                        }.padding(.top, 25)
                    }
            
            
        
        .padding(.horizontal, 25)
        
    }
    
   
    
}








class AboutApp: UIHostingController<Home3>{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: Home3());
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
        
    }
    
  

}
