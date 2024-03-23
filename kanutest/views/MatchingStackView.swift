//
//  MatchingStackView.swift
//  kanutest
//
//  Created by Soongyu Kwon on 3/24/24.
//

import SwiftUI

struct MatchingStackView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = WebViewModel()
    @AppStorage("sessionid") private var sessionID: String = ""
    @Binding var userID: String
    
    @State private var showMessageStackView: Bool = false
    @State private var messageStackViewData: String = ""
    
    var body: some View {
        NavigationStack {
            WebView(url: "https://kanu-webview.netlify.app/matching/\(self.userID)?sessionID=\(sessionID)", viewModel: self.viewModel)
                .navigationDestination(isPresented: self.$showMessageStackView, destination: {
                    MessageStackView(roomID: self.$messageStackViewData)
                })
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("messageStackView"))) { (object) in
            print("hello")
            self.messageStackViewData = object.object as! String
            self.showMessageStackView = true
        }
    }
}

#Preview {
    MatchingStackView(userID: .constant("123"))
}
