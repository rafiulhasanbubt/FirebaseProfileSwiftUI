//
//  UserProfileRepository.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 14/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserProfile: Codable {
  var uid: String
  var firstName: String
  var lastName: String
  var city: String
}

class UserProfileRepository: ObservableObject {
    private var db = Firestore.firestore()
    
    func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        do {
            let _ = try db.collection("profiles").document(profile.uid).setData(from: profile)
            completion(profile, nil)
        }
        catch let error {
            print("Error writing city to Firestore: \(error)")
            completion(nil, error)
        }
    }
    
    func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        db.collection("profiles").document(userId).getDocument { (snapshot, error) in
            let profile = try? snapshot?.data(as: UserProfile.self)
            completion(profile, error)
        }
    }
}
