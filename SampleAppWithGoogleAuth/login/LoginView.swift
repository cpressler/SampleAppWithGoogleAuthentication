//
//  LoginView.swift
//  Created by Chester Pressler on 8/3/20.
//
//  Copyright © 2020 Chester Pressler. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    

    
    var body: some View {
        VStack {
            Text("Welcome Back!")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign in to continue")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("Gray"))
            
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            MailLoginView()
                        
            //FaceBookLoginView().frame(width: 180, height: 50,alignment: .center).padding(10)
                        
            GoogleLoginView().frame(width: 140, height: 70,alignment: .center).padding(10)
            
            Spacer()
            
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text("I'm a new user.")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.primary)
                    
                    Text("Create an account")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("bg2"))
                }
            }
        }
        .padding(.horizontal, 32)
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign up to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("Gray"))
            
            VStack(spacing: 18) {
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .autocapitalization(.none)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("bg1"), lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .autocapitalization(.none)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("bg1"), lineWidth: 1))
            }.padding(.vertical, 64)
            
            Button(action: signUp) {
                Text("Create Account")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color("bg1"), Color("bg2")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }.padding(.horizontal, 32)
    }
}

struct LoginView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore())
    }
}
