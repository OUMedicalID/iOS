//
//  RegisterPView.swift
//  Email RegisterP Page
//
//  Created by Nguyen Viet Tien on 8/19/20.
//  Copyright © 2020 Nguyen Viet Tien. All rights reserved.
//

import SwiftUI

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
            
            // Sign in button
            Button(action: {
                self.Verify()
            }) {
                Text("Sign in")
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
                Text("Don't have an account ?")
                
                NavigationLink(destination: SignUp()){
                    Text("Sign up")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Dominant"))
                }
                
                Text("now").multilineTextAlignment(.leading)
                
            }.padding(.top, 25)
        }
        .padding(.horizontal, 25)
        
    }
    
    func Verify(){
        if self.email != "" && self.pass != ""{
           
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
}



class RegisterPage: UIHostingController<RegisterPView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: RegisterPView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
