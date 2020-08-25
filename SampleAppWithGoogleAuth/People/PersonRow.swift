//
//  PersonRow.swift
//  SampleAppWithGoogleAuth
//
//  Created by Chester Pressler on 8/24/20.
//  Copyright © 2020 Chester Pressler. All rights reserved.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack {
        // Older library files NOT needed
            //PersonPhotoView(url: person.picture.thumbnail, showActiity: false)
        PersonImageView(urlImage: person.picture.thumbnail)
            Text(person.name.first + " " +  person.name.last)
        }
        //Text("Hello")
    }
}

struct PersonRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let nameTest: Name = Name(title: "Mr", first: "Test", last: "Person")
        let loginTest: Login = Login(uuid: "", username: "", password: "", salt: "", md5: "", sha1: "", sha256: "")
        let picTest: Picture = Picture(large: "https://randomuser.me/api/portraits/women/21.jpg", medium: "https://randomuser.me/api/portraits/med/women/21.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/21.jpg")
        let street: Street = Street(number: 1234, name: "Main Street")
        let coordinates: Coordinates = Coordinates(latitude: "87.123", longitude: "47.123")
        let location: Location = Location(street: street, city: "AnyTown", state: "NV", country: "USA", gps: coordinates)
        let personTest: Person  = Person(gender: "male", email: "test", name: nameTest, login: loginTest, picture: picTest, nationality: "us", location: location)
        
        return PersonRow(person: personTest)
    }
}
