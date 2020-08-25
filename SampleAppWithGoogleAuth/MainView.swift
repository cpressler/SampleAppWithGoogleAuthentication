//
//  MainView.swift
//  FireBase_Authentication_Tutorial
//
//  Created by Chester Pressler on 8/12/20.
//  Copyright © 2020 Chester Pressler All rights reserved.
//

import SwiftUI
import os.log

struct MainView: View {
    
    @ObservedObject var peopleStore: PeopleStore
    
    @EnvironmentObject var session: SessionStore

    var body: some View {
        NavigationView {
            VStack {
                Text("MainView")
                NavigationLink(destination: PeopleView(peopleStore: peopleStore)) {
                //NavigationLink(destination: PeopleView(peopleStore: PeopleStore())) {
                        Text("Goto People")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("bg2"))
                }
                Spacer()
                Button(action: session.signOut) {
                    Text("Sign Out")
                }
            }
        }
        .onAppear() {
        self.peopleStore.getNames()
        os_log("MainView")

     }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let people: PeopleStore = PeopleStore()
        
        //return MainView().environmentObject(SessionStore())
        return MainView(peopleStore: people).environmentObject(SessionStore())
    }
}
