//
//  MailLoginView.swift
//  FireBase_Authentication_Tutorial
//
//  Created by Chester Pressler on 8/3/20.
//  Copyright © 2020 Chester Pressler. All rights reserved.
//

import SwiftUI
import Firebase
import os.log

struct MailLoginView: View {
    @EnvironmentObject var session: SessionStore
    
    @State private var emailString = ""
    @State private var password = ""
    @State var error: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var showLogin = false
    
    func signIn() {
        os_log("mailogin signIn",  type: .debug)
        error = ""
        
        session.signIn(email: emailString, password: password) { (result, error) in
            if let error = error {
                os_log("error log message.",  type: .debug)
                os_log( "Simple log with some %s.", error.localizedDescription)
                self.error = error.localizedDescription
            } else {
                os_log("reset login info",  type: .debug)
                self.emailString = ""
                self.password = ""
            }
        }
    }
    
    func signUp() {

        session.signUp(email: emailString, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.emailString = ""
                self.password = ""
            }
        }
    }
    
    func signOut() {
        os_log("mailogin signout",  type: .debug)
        session.signOut()
    }
    
    var body: some View {
        VStack() {
            if showLogin {
                TextField("Email", text: $emailString).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                .autocapitalization(.none)
                TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                .autocapitalization(.none)
                Button(action: {
                    self.signIn()
                }){
                    HStack {
                        Text(" SIGN IN")
                            .font(.body).bold()
                        
                    }
                    .frame(minWidth: 0, maxWidth: 140)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color("bg1"), Color("bg2")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                }
            } else {
                Button(action: {
                    self.showLogin = !self.showLogin
                }){
                    HStack {
                        Image(systemName: "envelope.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(" Sign In")
                            .font(.body).bold()
                        
                    }
                    .frame(minWidth: 0, maxWidth: 140)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color("bg1"), Color("bg2")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                }
            }

        }.animation(.spring())
    }
    
    func addUserToServer() {
        Auth.auth().createUser(withEmail: emailString, password: password) { authResult, error in
            
            if error != nil {
                self.alertMessage = error!.localizedDescription
            }else {
                self.alertMessage = "\(authResult!.user.email!) created"
                self.emailString = ""
                self.password = ""
            }
            self.showAlert = true
        }
    }
}

struct MailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        //MailLoginView()

        MailLoginView()

    }
}
