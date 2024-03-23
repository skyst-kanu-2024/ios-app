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
    @AppStorage("sessionid") var sessionID: String = ""
    
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
            
            AF.request("https://wget.kr/api/auth", method: .post, parameters: ["token": result.user.idToken!.tokenString], encoder: JSONParameterEncoder.default).responseData() { response in
                print(response.response?.statusCode)
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let json = try decoder.decode(LoginUser.self, from: data)
                        sessionID = json.session_id
                        self.isLogined = true
                    } catch {
                        print("error")
                    }
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct LoginUser: Codable, Hashable {
    let session_id: String
}

#Preview {
    LoginView(isLogined: .constant(false))
}
