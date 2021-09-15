//
//  CustonTabView.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 15/9/21.
//

import SwiftUI
import FirebaseAuth

struct CustonTabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Image(systemName: "star.square")
                .font(.system(size: 36))
                .frame(width: 36, height: 36)
            Spacer()
            Image(systemName: "bell.fill")
                .font(.system(size: 36))
                .frame(width: 36, height: 36)
            Spacer()
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    print("Signed out")
                    self.presentationMode.wrappedValue.dismiss()
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }, label: {
                Text("Logout")
                    .padding(.all, 6)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            })
            .frame(width: 60, height: 36)
            .background(Color.blue)
            .cornerRadius(10)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .background(Color.white)
        .border(Color.gray, width: 0.5)
    }
}

struct CustonTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustonTabView()
    }
}
