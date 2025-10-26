//
//  FaceID_TouchID_PassCode_AuthView.swift
//  FingerprintAuthenticationIniOS
//
//  Created by Gaurav Tak on 27/10/25.
//

import SwiftUI

struct FaceID_TouchID_PassCode_AuthView: View {
    @State private var isAuthenticated = false
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isAuthenticated ? "checkmark.circle.fill" : "lock.circle")
                .font(.system(size: 100))
                .foregroundColor(isAuthenticated ? .green : .gray)
            
            Text(isAuthenticated ? "Access Granted" : "Locked")
                .font(.title2)
            
            if !isAuthenticated {
                Button("Authenticate with FaceID or Touch ID or Passcode") {
                    BiometricAuth.shared.authenticateUser { success, error in
                        if success {
                            isAuthenticated = true
                            message = ""
                        } else {
                            message = error ?? "Authentication failed"
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                Text("Or").bold()
                Button("Authenticate with Face ID or Touch ID Only") {
                    BiometricAuth.shared.authenticateUserOnlyWithBiometric { success, error in
                        if success {
                            isAuthenticated = true
                            message = ""
                        } else {
                            message = error ?? "Authentication failed"
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
}
