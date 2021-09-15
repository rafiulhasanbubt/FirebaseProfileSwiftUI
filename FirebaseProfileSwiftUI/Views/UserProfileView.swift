//
//  UserProfileView.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 14/9/21.
//

import SwiftUI
import FirebaseAuth
import MapKit
import CoreLocation

struct UserProfileView: View {
    var userProfile: UserProfile
    @Environment(\.presentationMode) var presentationMode
    @StateObject var mapData = MapViewModel()
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all)
            
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "list.dash")
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $mapData.searchTxt)
                        Image(systemName: "mic")
                        Image(systemName: "arrow.uturn.forward.square.fill")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    if !mapData.places.isEmpty && mapData.searchTxt != "" {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(mapData.places) { place in
                                    Text(place.place.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            mapData.selectPlace(place: place)
                                        }
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }.background(Color.white)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Button(action: mapData.focusLocation, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    
                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType == .standard ? "network":"map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
                RecordView()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .background(Color.white)
                CustonTabView()
                    .padding(.bottom, 0)
            }
        }
        .onAppear(perform: {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title:Text("Permission Denied"), message: Text("Please Enable Permission in App Setting"), dismissButton: .default(Text("Goto Setting"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: { value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    self.mapData.searchQuery()
                }
            }
        })
        /*
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(userProfile.uid)
                    Text(userProfile.firstName)
                    Text(userProfile.lastName)
                    Text(userProfile.city)
                }
                
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
                })
                .padding(.bottom, 10)
            }
            .padding()
            .navigationBarTitle("User \(userProfile.uid)")
        }
 */
    }
}

struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    let userProfile = UserProfile(uid: "TEST1234", firstName: "Peter", lastName: "Friese", city: "Hamburg")
    return UserProfileView(userProfile: userProfile)
  }
}
