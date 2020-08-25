//
//  ContentView.swift
//  FireBase_Authentication_Tutorial
//
//  Created by Chester Pressler on 8/3/20.
//  Copyright © 2020 Chester Pressler. All rights reserved.
//

import SwiftUI
import os.log

struct ContentView: View {
    //@ObservedObject var peopleStore: PeopleStore
    
    @EnvironmentObject var session: SessionStore


    func getUser() {
        session.listen()
    }

    var body: some View {
        
        VStack() {
            Spacer()
            
            if (session.session != nil) {
                MainView(peopleStore: PeopleStore())
                //MainView()
                Spacer()
            } else {
                
            LoginView()
            Spacer()
            }
        }
        .animation(.spring())
        //.onAppear(perform: getUser)
            .onAppear() {
                self.getUser()
                os_log("ContentView")
                
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //let people: PeopleStore = PeopleStore()
       //ContentView(session: SessionStore())
        //ContentView(session: SessionStore(), peopleStore: PeopleStore())
//            .environmentObject(SessionStore())
//        .ObservedObject(PeopleStore())
        //return ContentView(peopleStore: people).environmentObject(SessionStore())
        return ContentView().environmentObject(SessionStore())
    }
}

