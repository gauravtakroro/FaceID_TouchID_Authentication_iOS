//
//  BiometricAuth.swift
//  FingerprintAuthenticationIniOS
//
//  Created by Gaurav Tak on 27/10/25.
//


import LocalAuthentication

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
                        let message = self.errorMessage(for: authError)
                        completion(false, message)
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
                        let message = self.errorMessage(for: authError)
                        completion(false, message)
                    }
                }
            }
        } else {
            completion(false, "Biometric(Face ID or Touch ID) authentication not available on this device")
        }
    }
    
    private func errorMessage(for error: Error?) -> String {
        guard let laError = error as? LAError else { return "Unknown error" }
        
        switch laError.code {
        case .authenticationFailed:
            return "Authentication failed. Try again."
        case .userCancel:
            return "Authentication was canceled by the user."
        case .userFallback:
            return "User chose to use a fallback method."
        case .biometryNotAvailable:
            return "Biometric authentication is not available on this device."
        case .biometryNotEnrolled:
            return "No Face ID or Touch ID enrolled."
        case .biometryLockout:
            return "Too many failed attempts. Try using your passcode."
        default:
            return "Authentication error: \(laError.localizedDescription)"
        }
    }
}
