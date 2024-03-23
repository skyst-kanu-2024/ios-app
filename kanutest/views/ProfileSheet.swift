//
//  ProfileSheet.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct ProfileSheet: View {
    @ObservedObject var viewModel = WebViewModel()
    @State var showProfileSheet: Bool = false
    
    var body: some View {
        WebView(url: "http://192.168.0.132:5173/profile/123", viewModel: self.viewModel)
    }
}

#Preview {
    ProfileSheet()
}
