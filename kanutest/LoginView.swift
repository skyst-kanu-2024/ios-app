//
//  LoginView.swift
//  kanutest
//
//  Created by Soongyu Kwon on 3/24/24.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn
import Alamofire

struct LoginView: View {
    @Binding var isLogined: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Serendipity")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.accent)
            Spacer()
            GoogleSignInButton(action: handleSignIn)
        }.padding()
    }
    
    func handleSignIn() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            guard let result = signInResult else {
                // Inspect error
                return
            }
            // If sign in succeeded, display the app's main content View.
            
//            AF.
            self.isLogined = true
        }
    }
}

#Preview {
    LoginView(isLogined: .constant(false))
}
