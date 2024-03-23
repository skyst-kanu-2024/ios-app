//
//  MyProfileView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct MyProfileView: View {
    @ObservedObject var viewModel = WebViewModel()
    @AppStorage("sessionid") private var sessionID: String = ""
    
    var body: some View {
        WebView(url: "http://192.168.10.124:5173/mypage?sessionID=\(sessionID)", viewModel: self.viewModel)
    }
}

#Preview {
    MyProfileView()
}
