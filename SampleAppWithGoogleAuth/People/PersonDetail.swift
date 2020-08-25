//
//  PersonDetail.swift
//  SampleAppWithGoogleAuth
//
//  Created by Chester Pressler on 8/24/20.
//  Copyright © 2020 Chester Pressler. All rights reserved.
//

import SwiftUI

struct PersonDetail: View {
    var person: Person
    
    var body: some View {
        VStack {
            //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            // older library call not used
            //PersonPhotoView(url: person.picture.large, showActiity: false)
            PersonImageView(urlImage: person.picture.thumbnail)
            Text(person.name.title + " " + person.name.first + " " +  person.name.last)
            HStack {
                Text("Email: ").font(.system(size: 18, weight: .heavy, design: .default))
                Text(person.email)
                }
            HStack {
                Text("Username: ").font(.system(size: 18, weight: .heavy, design: .default))
                Text(person.login.username)
            }
            
            HStack {
                Text("Nationality: ").font(.system(size: 14, weight: .heavy, design: .default))
                Text(person.nationality)
            }
            HStack {
                Text("coodinates: ").font(.system(size: 12, weight: .heavy, design: .default))
                Text(person.location.gps.latitude)
                Text(",")
                Text(person.location.gps.longitude)
            }
        }.navigationBarTitle(Text("People"), displayMode: .inline)
        
    }
}

struct PersonDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        let nameTest: Name = Name(title: "Mr", first: "Test", last: "Person")
        let loginTest: Login = Login(uuid: "", username: "bluegorilla190", password: "", salt: "", md5: "", sha1: "", sha256: "")
        let picTest: Picture = Picture(large: "https://randomuser.me/api/portraits/women/21.jpg", medium: "https://randomuser.me/api/portraits/med/women/21.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/21.jpg")
        //let personTest: Person  = Person(gender: "male", email: "test@example.com", name: nameTest, login: loginTest, picture: picTest, nationality: "us")
        
        let street: Street = Street(number: 1234, name: "Main Street")
        let coordinates: Coordinates = Coordinates(latitude: "87.123", longitude: "47.123")
        let location: Location = Location(street: street, city: "AnyTown", state: "NV", country: "USA", gps: coordinates)
        let personTest: Person  = Person(gender: "male", email: "test@example.com", name: nameTest, login: loginTest, picture: picTest, nationality: "us", location: location)
        return PersonDetail(person: personTest)
    }
}
