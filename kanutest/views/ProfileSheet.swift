//
//  ProfileSheet.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct ProfileSheet: View {
    @ObservedObject var viewModel = WebViewModel()
    @AppStorage("sessionid") var sessionID: String = ""
    @State var showProfileSheet: Bool = false
    @Binding var userID: String
    
    var body: some View {
        WebView(url: "http://192.168.10.124:5173/profile/\(self.userID)?sessionID=\(sessionID)", viewModel: self.viewModel)
            .onAppear() {
                print(sessionID)
            }
    }
}

#Preview {
    ProfileSheet(userID: .constant("123"))
}
