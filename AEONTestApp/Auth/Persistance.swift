//
//  Persistance.swift
//  AEONTestApp
//
//  Created by Nikita Makarov on 02.07.2021.
//

import Foundation

class Persistance {
    static let shared = Persistance()
    private let kUserToken = "Persistance.kUserToken"
   
    var userToken: String? {
        set{ UserDefaults.standard.set(newValue, forKey: kUserToken) }
        get { return UserDefaults.standard.string(forKey: kUserToken)}
    }
    
    
}
