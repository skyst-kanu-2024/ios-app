//
//  MessageListView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct MessageListView: View {
    @ObservedObject var viewModel = WebViewModel()
    @AppStorage("sessionid") private var sessionID: String = ""
    
    var body: some View {
        WebView(url: "https://kanu-webview.netlify.app/message-list?sessionID=\(sessionID)", viewModel: self.viewModel)
    }
}

#Preview {
    MessageListView()
}
