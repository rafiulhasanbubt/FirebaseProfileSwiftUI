//
//  SessionStore.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 14/9/21.
//

import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject {
    @Published var session: User?
    @Published var profile: UserProfile?
    
    private var profileRepository = UserProfileRepository()
    
    func signUp(email: String, password: String, firstName: String, lastName: String, city: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing up: \(error)")
                completion(nil, error)
                return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed up.")
            
            let userProfile = UserProfile(uid: user.uid, firstName: firstName, lastName: lastName, city: city)
            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                self.profile = profile
                completion(profile, nil)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing in: \(error)")
                completion(nil, error)
                return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed in.")
            
            self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                
                self.profile = profile
                completion(profile, nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
            self.profile = nil
        }
        catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
}
