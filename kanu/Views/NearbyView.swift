//
//  NearbyView.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI
import NearbyInteraction
import MultipeerConnectivity


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
    }
}

#Preview {
    NearbyView()
}
