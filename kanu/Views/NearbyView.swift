//
//  NearbyView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI
import NearbyInteraction
import MultipeerConnectivity
import Alamofire


struct NearbyView: View {
    @ObservedObject var viewModel = NearbyViewModel()
    
//    init(viewModel: NearbyViewModel) {
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Group {
                VStack {
                    VStack(alignment: .center) {
                        Text("대충엄청난닉네임")
                            .foregroundStyle(.gray)
                            .font(.caption)
                        Text("\(String(format: "%.2f", 0.0)) m")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        
                    }
                    Spacer()
                    Text("initialising...")
                        .foregroundStyle(.white)
                }.padding()
            }
        }.onAppear() {
            startup()
        }
    }
    
    func startup() {
        viewModel.startNearbySession()
        
        let parameter: [String: String] = [
            "roomid": "1",
            "userid": "1",
            "token": "hello_there"
        ]
        let tokenUpload = AF.request("https://wget.kr/dtoken", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default)
        
        tokenUpload.response() { response in
            print(response.response?.statusCode)
        }
        
//        let tokenGet = AF.request("https://wget.kr/dtoken?roomid=1&userid=2", method: .get)
//
//        tokenGet.response() { response in
//            print(response.response?.statusCode)
//        }
    }
}

#Preview {
    NearbyView()
}
