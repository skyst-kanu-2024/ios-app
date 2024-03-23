//
//  RootView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI
import Alamofire

struct RootView: View {
    @ObservedObject var viewModel = WebViewModel()
    @AppStorage("sessionid") var sessionID: String = ""
    
    @State private var showProfileSheet: Bool = false
    @State private var profileSheetData: String = ""
    
    @State private var showMatchingStackView: Bool = false
    @State private var matchingStackViewData: String = ""
    
    var body: some View {
        NavigationStack {
            WebView(url: "http://192.168.10.124:5173?sessionID=\(sessionID)", viewModel: self.viewModel)
                .sheet(isPresented: self.$showProfileSheet, content: {
                    ProfileSheet(userID: self.$profileSheetData)
                })
                .navigationDestination(isPresented: self.$showMatchingStackView, destination: {
                    MatchingStackView(userID: self.$matchingStackViewData)
                })
                .onReceive(self.viewModel.profileSheet.receive(on: RunLoop.main)) { value in
                    self.showProfileSheet = value
                }
                .onReceive(self.viewModel.profileSheetData.receive(on: RunLoop.main)) { value in
                    self.profileSheetData = value
                }
                .onReceive(NotificationCenter.default
                    .publisher(for: NSNotification.Name("matchingStackView"))) { (object) in
                        self.matchingStackViewData = object.object as! String
                        self.showMatchingStackView = true
                }
                .onAppear() {
                    AF.request("https://wget.kr/api/location", method: .post, parameters: ["lat": 37.50631, "lng": 127.02263], encoder: JSONParameterEncoder.default, headers: ["sessionid": self.sessionID]).response { response in
                        print(response.response?.statusCode)
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
