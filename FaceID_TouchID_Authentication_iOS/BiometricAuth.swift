//
//  BiometricAuth.swift
//  FingerprintAuthenticationIniOS
//
//  Created by Gaurav Tak on 27/10/25.
//


import LocalAuthentication
import SwiftUI

class BiometricAuth {
    
    static let shared = BiometricAuth()
    
    private init() {}
    
    func authenticateUser(completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports biometrics
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Authenticate using your Face ID or Touch ID or Passcode to access secure data"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil)
                    } else {
                        completion(false, authError?.localizedDescription)
                    }
                }
            }
        } else {
            completion(false, "Face ID or Touch ID or Passcode authentication not available on this device")
        }
    }
    
    func authenticateUserOnlyWithBiometric(completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports biometrics
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Authenticate using your Face ID or Touch ID to access secure data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil)
                    } else {
                        completion(false, authError?.localizedDescription)
                    }
                }
            }
        } else {
            completion(false, "Biometric(Face ID or Touch ID) authentication not available on this device")
        }
    }
}
