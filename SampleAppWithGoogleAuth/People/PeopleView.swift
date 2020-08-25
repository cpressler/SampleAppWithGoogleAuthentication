//
//  PeopleView.swift
//  SampleAppWithGoogleAuth
//
//  Created by Chester Pressler on 8/14/20.
//  Copyright © 2020 Chester Pressler. All rights reserved.
//

import SwiftUI
import os.log

struct PersonPhotoView: View {
    let url: String
    let showActivity: Bool
    
    var loader: ViewLoader = ViewLoader(url: "")

    init(url: String, showActiity: Bool) {
        self.url = url
        self.loader = ViewLoader(url: url )
        self.showActivity = true
    }
    
    var body: some View {
        ViewWithActivityIndicator(placeHolder: "", showActivityIndicator: self.showActivity, viewLoader: self.loader) {
                Image(uiImage: UIImage(data:self.loader.getData()) ?? UIImage())
        }
    }
}
struct PersonImageView: View {
    let urlImage: String
    

    init(urlImage: String) {
        self.urlImage = urlImage
    }
    
    var body: some View {
        UrlImageView(urlString: urlImage)
        }
}


struct PeopleView: View {
     @ObservedObject var peopleStore: PeopleStore
    
    var loader: ViewLoader = ViewLoader(url: "")
    var body: some View {
        //NavigationView {
        VStack() {
            List(peopleStore.peoplelist.all , id: \.login.uuid){
                person in
                NavigationLink(destination: PersonDetail(person: person)) {
                    PersonRow(person: person)
                }
            }
            Text("Version:  \(peopleStore.peoplelist.info.version)")
        //}
        .navigationBarTitle(Text("People List"))
        .onAppear() {
            //self.peopleStore.getNames()
            os_log("PeopleView")
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        let people: PeopleStore = PeopleStore()
        print ( people )
        people.getNames()
        return PeopleView(peopleStore: people)
    }
}
