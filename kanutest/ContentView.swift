//
//  ContentView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLogined = false
    @AppStorage("sessionid") var sessionID: String = ""
    
    var body: some View {
        if isLogined || sessionID != "" {
            TabView {
                RootView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                MessageListView()
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                    }
                MyProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
        } else {
            LoginView(isLogined: self.$isLogined)
        }
    }
}

#Preview {
    ContentView()
}
