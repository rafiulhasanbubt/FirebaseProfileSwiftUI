//
//  Place.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 15/9/21.
//

import Foundation
import MapKit

struct Place: Identifiable {
    var id = UUID().uuidString
    var place: CLPlacemark
}
