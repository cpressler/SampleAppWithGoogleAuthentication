//
//  PeopleStore.swift
//  SampleAppWithGoogleAuth
//
//  Created by Chester Pressler on 8/13/20.
//  Copyright © 2020 Chester Pressler All rights reserved.
//

import Foundation
import Alamofire
import os.log


struct ApiInfo: Decodable {
    var seed: String = ""
    var results: Int = 1
    var page: Int = 1
    var version: String = ""
    
    enum CodingKeys: String, CodingKey {
        case seed
        case results
        case page
        case version
    }
    
}

struct People: Decodable {
    var info: ApiInfo = ApiInfo ()
    var all: [Person] =  [Person]()
   
  
  enum CodingKeys: String, CodingKey {
    case all = "results"
    case info = "info"
  }

}

struct Name: Decodable {
    
    let title : String
    let first: String
    let last: String
    
    enum CodingKeys: String, CodingKey {
      case title
      case first = "first"
      case last
    }
}
    
struct Login: Decodable {
    
    let uuid : String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String

    enum CodingKeys: String, CodingKey {
    case uuid
    case username
    case password
    case salt
    case md5
    case sha1
    case sha256
    }
}

struct Street: Decodable {
    let number: Int
    let name: String

    enum CodingKeys: String, CodingKey {
    case number
    case name
    }
}

struct Coordinates: Decodable {
    let latitude: String
    let longitude: String

    enum CodingKeys: String, CodingKey {
    case latitude
    case longitude
    }
}
    
struct Location: Decodable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let gps: Coordinates

    enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case country
        case gps = "coordinates"
    }
}

struct Picture: Decodable {
    
    let large : String
    let medium: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
    case large
    case medium
    case thumbnail
    }
}


struct Person: Decodable {

    let gender: String
    let email: String
    let name: Name
    let login: Login
    let picture: Picture
    let nationality: String
    let location: Location
  
    enum CodingKeys: String, CodingKey {
        case gender
        case name = "name"
        case email = "email"
        case login
        case picture
        case nationality = "nat"
        case location = "location"
    }
}


class PeopleStore:  ObservableObject{
    //@Published var peoplelist: People = People(all: [Person]())
    @Published var peoplelist: People  = People()
    //@Published var peoplelist: [Person]? = [Person]()
    
    func getNames() {
        os_log("getNames")
        let parameters: [String: Any] = ["results": "10" , "nat" : "us"]
        let randomnameUrl: String = "https://randomuser.me/api"
        
        AF.request(randomnameUrl, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: People.self) { (response) in
                debugPrint(response)
                guard let people = response.value else { return }
                //print(people.all[0].name)
                //print(people.all[0].login)
                //self.peoplelist.all = people.all
                self.peoplelist = people
                //print(people.info.version)
                //print("INFO" , people.info)
                //self.peoplelist.info = people.info
                //os_log("getNamesResponse ($response)"  )
            switch response.result {
            case .success:
                os_log("Validation Successful")
            case let .failure(error):
                let errormsg = error.localizedDescription
                os_log("%@", errormsg)
            }
            //print("Response: \(response)")
        }
       os_log("getNamesCompleted")
    }
}

/** Example call for the decode process
 {"results":[{"gender":"male","name":{"title":"Mr","first":"Kenneth","last":"Bennett"},"location":{"street":{"number":5043,"name":"Prospect Rd"},"city":"Baltimore","state":"South Dakota","country":"United States","postcode":61252,"coordinates":{"latitude":"-81.2105","longitude":"-3.0468"},"timezone":{"offset":"-2:00","description":"Mid-Atlantic"}},"email":"kenneth.bennett@example.com","login":{"uuid":"9068a1c9-6afc-4a0c-af46-38dacab06d9c","username":"crazykoala287","password":"zxcvbn","salt":"zQ0UNaVx","md5":"08d4f74e62b551bb552c032a2ed58df0","sha1":"f5fc8da70ab69009ed1825f97763c6e385f7af10","sha256":"763501fd2c1849fae2e431ecf94d3ff8898d7a66d2ffd7ef722e78966684e584"},"dob":{"date":"1974-03-08T19:29:30.355Z","age":46},"registered":{"date":"2017-06-01T15:41:31.611Z","age":3},"phone":"(767)-038-6892","cell":"(748)-781-8690","id":{"name":"SSN","value":"796-98-7670"},"picture":{"large":"https://randomuser.me/api/portraits/men/68.jpg","medium":"https://randomuser.me/api/portraits/med/men/68.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/men/68.jpg"},"nat":"US"}],"info":{"seed":"9fff61446f94c0c6","results":1,"page":1,"version":"1.3"}}
 */
