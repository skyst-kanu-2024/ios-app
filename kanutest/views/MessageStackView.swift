//
//  MessageStackView.swift
//  kanutest
//
//  Created by Soongyu Kwon on 3/24/24.
//

import SwiftUI

struct MessageStackView: View {
    @ObservedObject var viewModel = WebViewModel()
    @AppStorage("sessionid") private var sessionID: String = ""
    @Binding var roomID: String
    
    var body: some View {
        NavigationStack {
            WebView(url: "http://192.168.10.124:5173/message/\(self.roomID)?sessionID=\(sessionID)", viewModel: self.viewModel)
        }
    }
}

#Preview {
    MessageStackView(roomID: .constant("wowsans"))
}