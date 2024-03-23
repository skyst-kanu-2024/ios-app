//
//  ProfileSheet.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct ProfileSheet: View {
    @ObservedObject var viewModel = WebViewModel()
    @Environment(\.dismiss) var dismiss
    @AppStorage("sessionid") private var sessionID: String = ""
    @State var showProfileSheet: Bool = false
    @Binding var userID: String
    
    var body: some View {
        WebView(url: "https://kanu-webview.netlify.app/profile/\(self.userID)?sessionID=\(sessionID)", viewModel: self.viewModel)
            .onReceive(self.viewModel.matchingStackView.receive(on: RunLoop.main)) { value in
                if value {
                    dismiss()
                }
            }
    }
}

#Preview {
    ProfileSheet(userID: .constant("123"))
}
