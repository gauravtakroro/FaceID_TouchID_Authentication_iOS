//
//  ContentView.swift
//  FaceID_TouchID_Authentication_iOS
//
//  Created by Gaurav Tak on 27/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            FaceID_TouchID_PassCode_AuthView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
