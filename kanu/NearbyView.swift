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
    
    @State private var proximity: Float = 0.0
    
    @State private var session: NISession?
    
    
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
                        Text("\(String(format: "%.2f", self.proximity)) m")
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
        self.session = NISession()
        
    }
}

class NISessionController: NSObject, NISessionDelegate {
    @ObservedObject var viewModel: WebViewModel
    
    
}

#Preview {
    NearbyView()
}
