//
//  ContentView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RootView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            MessageListView()
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    Text("메시지")
                }
            MyProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("프로필")
                }
        }
    }
}

#Preview {
    ContentView()
}
