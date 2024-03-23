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
import SDWebImageSwiftUI

struct NearbyView: View {
    @ObservedObject var viewModel = NearbyViewModel()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Group {
                VStack {
                    VStack(alignment: .center) {
                        Text("수노수노")
                            .foregroundStyle(.gray)
                            .font(.caption)
                        Text("\(String(format: "%.2f", self.viewModel.distanceToPeerDevice)) m")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                    }
                    Spacer()
                    AnimatedImage(url: URL(string: "https://static.toss.im/3d-emojis/u2764-apng.png")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                    Spacer()
                    Text("주위를 둘러보며 상대를 찾아보세요")
                        .foregroundStyle(.white)
                }.padding()
            }
        }.onAppear() {
            startup()
        }
        .onReceive(timer) { _ in
            if viewModel.isNearbySessionEstablished {
                getPeerToken()
            }
        }
    }
    
    func startup() {
        viewModel.startNearbySession()
        uploadLocalToken()
        getPeerToken()
    }
    
    func uploadLocalToken() {
        if let discoveryToken = viewModel.getLocalDiscoveryToken() {
            if let encodedToken = try? NSKeyedArchiver.archivedData(withRootObject: discoveryToken, requiringSecureCoding: true) {
                print(encodedToken.base64EncodedString())

                let parameter: [String: String] = [
                    "roomid": "1",
                    "userid": "1",
                    "token": encodedToken.base64EncodedString()
                ]
                let tokenUpload = AF.request("https://wget.kr/api/dtoken", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default)

                tokenUpload.response() { response in
                    print(response.response?.statusCode ?? 0)
                }
            }
        }
    }
    
    func getPeerToken() {
        AF.request("https://wget.kr/api/dtoken?roomid=1&userid=1", method: .get).responseData() { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let json = try decoder.decode(Peer.self, from: data)
                    if let data = Data(base64Encoded: json.token) {
                        if let decodedToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) {
                            self.viewModel.setPeerDiscoveryToken(token: decodedToken)
                            self.viewModel.initiateNearbySession()
                        }
                    }
                } catch {
                    print("error")
                    getPeerToken()
                }
            case .failure(let error):
                print(error)
                getPeerToken()
            }
        }
    }
}

struct Peer: Codable, Hashable {
    let token: String
}

#Preview {
    NearbyView()
}
