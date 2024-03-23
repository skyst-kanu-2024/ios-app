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
                        Text("\(String(format: "%.2f", self.viewModel.distanceToPeerDevice)) m")
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
        if let discoveryToken = viewModel.getLocalDiscoveryToken() {
            if let encodedToken = try? NSKeyedArchiver.archivedData(withRootObject: discoveryToken, requiringSecureCoding: true) {
                print(encodedToken.base64EncodedString())
                
                let parameter: [String: String] = [
                    "roomid": "3",
                    "userid": "1",
                    "token": encodedToken.base64EncodedString()
                ]
                let tokenUpload = AF.request("https://wget.kr/dtoken", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default)
                
                tokenUpload.response() { response in
                    print(response.response?.statusCode)
                }
            }
        }
        getPeerToken()
    }
    
    func getPeerToken() {
        AF.request("https://wget.kr/dtoken?roomid=3&userid=1", method: .get).responseData() { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let json = try decoder.decode(Peer.self, from: data)
                    if let data = Data(base64Encoded: json.token) {
                        if let decodedToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) {
                            print(decodedToken)
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
