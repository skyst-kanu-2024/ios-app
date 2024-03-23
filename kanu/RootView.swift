//
//  RootView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct RootView: View {
    let webView = WebView()
    
    var body: some View {
        self.webView
            .onAppear() {
                self.webView.loadURL(urlString: "https://kanu-webview.netlify.app/")
            }
    }
}

#Preview {
    RootView()
}
