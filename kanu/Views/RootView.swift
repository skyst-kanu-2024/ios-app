//
//  RootView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel = WebViewModel()
    @State var showProfileSheet: Bool = false
    
    
    var body: some View {
        WebView(url: "http://192.168.0.132:5173/debug", viewModel: self.viewModel)
            .sheet(isPresented: self.$showProfileSheet, content: {
                ProfileSheet()
            })
            .onReceive(self.viewModel.bar.receive(on: RunLoop.main)) { value in
                self.showProfileSheet = value
            }
    }
}

#Preview {
    RootView()
}
