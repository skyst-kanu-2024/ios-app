//
//  RootView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel = WebViewModel()
    
    @State private var showProfileSheet: Bool = false
    @State private var profileSheetData: String = ""
    
    var body: some View {
        WebView(url: "http://192.168.10.124:5173?sessionID=testsessionid", viewModel: self.viewModel)
            .sheet(isPresented: self.$showProfileSheet, content: {
                ProfileSheet(userID: self.$profileSheetData)
            })
            .onReceive(self.viewModel.profileSheet.receive(on: RunLoop.main)) { value in
                self.showProfileSheet = value
            }
            .onReceive(self.viewModel.profileSheetData.receive(on: RunLoop.main)) { value in
                self.profileSheetData = value
            }
    }
}

#Preview {
    RootView()
}
