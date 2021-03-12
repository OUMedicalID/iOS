//
//  RegisterPView.swift
//  Email RegisterP Page
//
//  Created by Nguyen Viet Tien on 8/19/20.
//  Copyright © 2020 Nguyen Viet Tien. All rights reserved.
//

import SwiftUI
import Alamofire


struct RegisterPView: View {
    var body: some View {
        RegisterPH()
    }
}

struct RegisterPView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPView()
    }
}

struct RegisterPH: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        VStack{
            if self.status{
                RegisterPHScreen()
                
            } else {
                VStack{
                    RegisterP()
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

struct RegisterPHScreen: View{
    var body: some View{
        VStack{
            
            Image("register").resizable().frame(width: 300.0, height: 225.0, alignment: .center)
            
            Text("Signed in successfully")
                .font(.title)
                .fontWeight(.bold)
            
            Button(action: {
                
                
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


struct RegisterP: View{
    
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
            
            Text("Registration")
                .font(Font.custom("Montserrat-Bold", size: 35.0))
                .fontWeight(.bold)
                .padding(.top, 15)
                .foregroundColor(Color(red: 0.00, green: 0.69, blue: 1.00))
            
            Text("Securely carry your medical data with you")
                .font(Font.custom("Montserrat-Light", size: 13.0))
                .fontWeight(.bold)
                .padding(.top, 5)
                .foregroundColor(Color(red: 0.00, green: 0.69, blue: 1.00))
            
            
            
            Image("register").resizable().frame(width: 300.0, height: 255.0, alignment: .top)
            
            Text("Register for a new account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            TextField("Username or Email",text:self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                .padding(.top, 0)
            
            HStack(spacing: 15){
                VStack{
                    if self.visible {
                        TextField("Password", text: self.$pass)
                            .autocapitalization(.none)
                            .frame(height: 27) // Added this height to prevent a bug from changing the width when hiding/unhiding pass.
                    } else {
                        SecureField("Password", text: self.$pass)
                            .autocapitalization(.none)
                            .frame(height: 27)
                    }
                }
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
            .stroke(borderColor,lineWidth: 2))
            .padding(.top, 10)
            
            
            /*HStack{
                Spacer()
                Button(action: {
                    self.ResetPassword()
                    self.visible.toggle()
                }) {
                    Text("Forget Password")
                        .fontWeight(.medium)
                        .foregroundColor(Color("Dominant"))
                }.padding(.top, 10.0)
            }*/
            
            
            Text("Password must be 8+ characters, contain at least one number and at least one special character ")
                .padding(.top, 15)
                .font(Font.custom("X", size: 12))
            
            
            
            
            // Sign in button
            Button(action: {
                self.Verify()
            }) {
                Text("Sign up")
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
                Text("Already have an account?")
                
                Button(action: {
                    transitionToLogin()
                }) {
                    Text("sign in")
                        .fontWeight(.medium)
                        .foregroundColor(Color("Dominant"))
                }
                
                Text("now").multilineTextAlignment(.leading)
                
            }.padding(.top, 25)
        }
        .padding(.horizontal, 25)
        
    }
    
    func Verify(){
        if self.email != "" && self.pass != ""{
           
            /// TO DO HERE: VERIFY EMAIL,PASS, create the account in server and transition to login page.
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            let regex2 = try! NSRegularExpression(pattern:
                "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$", options: .caseInsensitive)

            if( regex.firstMatch(in: self.email, options: [], range: NSRange(location: 0, length: self.email.count)) != nil && regex2.firstMatch(in: self.pass, options: [], range: NSRange(location: 0, length: self.pass.count)) != nil ){
                
                
                let sha512Password = HelperFunctions().sha512(password: self.pass).prefix(32)
                let email = HelperFunctions().encryptData2(data: self.email, key: String(sha512Password))
                
                
                
                let parameters = ["email": email]
                
                let url = HelperFunctions().domain + "/register.php"
                AF.request(url, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default, headers: [:])
                    .responseJSON { (response) in
                        switch response.result {
                           case .success(let value):
                                if let JSON = value as? [String: Any] {
                                    let status = JSON["succes"] as! String
                                    
                                    if(status == "success"){
                                        transitionToLogin()
                                    }else{
                                        self.title = "Error"
                                        self.error = "An error occured."
                                        self.alert = true
                                    }
                                    
                                }
                                break
                            case .failure:
                                print(Error.self)
                            }
                        }
                
                
                
                
            }else{
                self.title = "Error"
                self.error = "Please fill out a valid email"
                self.alert = true
            }
            
            
        }else{
            self.title = "RegisterP Error"
            self.error = "Please fill all the content property"
            self.alert = true
        }
    }
    
    func ResetPassword(){
        if self.email != ""{
            
        
        }else{
            
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }

    func Register(){
        if self.email != ""{
            
            
        }else{
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
        
    }
    
    
    func transitionToLogin(){
        print("click")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "login"), object: nil)
    }
}



class RegisterPage: UIHostingController<RegisterPView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: RegisterPView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.login(_:)), name: NSNotification.Name(rawValue: "login"), object: nil)
    }
    
    
    @objc func login(_ notification: NSNotification) {
        //dismiss(animated: true, completion: nil)
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "LoginRegister", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "lr_login") as! LoginPage
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)*/
        
        performSegue(withIdentifier: "registertoLogin", sender: self)
    }
    
}
