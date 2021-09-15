//
//  LoginView.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 15/9/21.
//

import SwiftUI

struct LoginView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var showDetails: Bool
    @Binding var profile: UserProfile?

    @ObservedObject var sessionStore = SessionStore()
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
              .textContentType(.emailAddress)
              .autocapitalization(.none)
            SecureField("Password", text: $password)
            
            Button(action: { self.signIn() }) {
              Text("Sign in")
            }
            
            Spacer()
        }
        .padding()
    }
    
    func signIn() {
      sessionStore.signIn(email: self.email, password: self.password) { (profile, error) in
        if let error = error {
          print("Error when signing up: \(error)")
          return
        }
        self.profile = profile
        self.showDetails.toggle()
      }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(email: .constant("rafi"), password: .constant("123456"))
//    }
//}
