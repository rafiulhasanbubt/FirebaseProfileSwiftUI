//
//  SignupView.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 15/9/21.
//

import SwiftUI

struct SignupView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var city: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String    
    @Binding var showDetails: Bool

    @ObservedObject var sessionStore = SessionStore()
    @Binding var profile: UserProfile?
    
    var body: some View {
        VStack {
            Section {
              TextField("First name", text: $firstName)
                .textContentType(.givenName)
                .disableAutocorrection(true)
                .autocapitalization(.none)
              TextField("Last name", text: $lastName)
                .textContentType(.familyName)
                .disableAutocorrection(true)
                .autocapitalization(.none)
              TextField("City", text: $city)
                .textContentType(.addressCity)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            }
            Section {
              TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
              SecureField("Password", text: $password)
              SecureField("Confirm password", text: $confirmPassword)
            }
            
            Button(action: { self.signUp() }) {
              Text("Sign up")
            }
            
            Spacer()
            
        }.padding()
    }
    
    func signUp() {
      sessionStore.signUp(email: self.email, password: self.password, firstName: self.firstName, lastName: self.lastName, city: self.city) { (profile, error) in
        if let error = error {
          print("Error when signing up: \(error)")
          return
        }
        print("Profile created successfully")
        self.profile = profile
        self.showDetails.toggle()
      }
    }
}

//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
